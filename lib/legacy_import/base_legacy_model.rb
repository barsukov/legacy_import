LEGACY_CLASS_PATH = "LegacyModels::Legacy"
#TODO Довести до ума импорт для того что бы его можно было вынести в отдельный гем
class LegacyBase < ActiveRecord::Base
  establish_connection Rails.configuration.database_configuration["legacy_#{Rails.env}"]
  self.abstract_class = true
  attr_writer :legacy_class_path
  attr_accessor :original_model_name

  def self.legacy_class_path
    @legacy_class_path || "LegacyModels::LegacyBase::Legacy"
  end

  def self.original_model_name
    @original_model_name || get_original_model_constant
  end

  class << self
    def get_original_model_constant()
      new_model_name = self.name
      new_model_name.slice! self.legacy_class_path
      new_model_name.constantize
    end

    def remove_keys_from_update_attributes(deleted_keys, updated_attributes)
      deleted_keys.each { |key| updated_attributes.delete(key) if updated_attributes.has_key? key }
    end

    def simple_update_without_merge(original_model_instance,attributes)
      original_model_instance.assign_attributes(attributes, :without_protection => true)
      original_model_instance.save! unless original_model_instance.class.exists? original_model_instance
    end

    def merge_matching_attributes(matching_attributes, attributes)
      attributes.keys.each { |k| attributes[matching_attributes[k]] = attributes.delete(k) if matching_attributes[k] }
      attributes
    end

    def import(&block)
      new_model_instance = self.original_model_name
      #TODO smels variable for merge strategy when we realize normal configuration dsl remove it variable
      legacy_instance = self.first
      @without_merge = !!legacy_instance.attributes.keys.detect {|key| key =~ /_ru/}
      self.all.map do |legacy_model|
        begin
          new_model = new_model_instance.new
          if (block_given?)
            block.call new_model,legacy_model
          else
            legacy_attributes = legacy_model.attributes
            new_model_attributes = new_model.attributes
            unless (@without_merge)
              new_model_attributes.merge! legacy_attributes.select { |k| new_model_attributes.keys.include? k }
              legacy_attributes = new_model_attributes
            end
            simple_update_without_merge new_model,legacy_attributes
          end
        rescue => e
          puts " error: #{e}"
          raise Exception
        end
      end
    end
  end
end


