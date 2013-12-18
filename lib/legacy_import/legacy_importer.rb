module LegacyImporter
  require "legacy_import/legacy_models"
  attr_accessor :imported_models

  class << self
    def get_only_acceptance_model
      LegacyImport.config.acceptable_models
    end

    def get_only_ignored_model
      LegacyImport.config.ignored_models
    end

    def get_special_params

    end

    def has_special_params?

    end
  end


  def self.create_legacy_models
    models = get_only_acceptance_model
    not_eval_klasses = []
    klasses = models.each do |model|

      #If model has nesting we need to slice :: symbol for correct mapping to the table
      #TODO make custom mapping to tables.
      if (model =~ /\W:/)
        original_model_constant = model.constantize
        model.slice! "::"
      else
        original_model_constant = Module.const_get model
      end
      klass =  "Legacy#{model.classify}"
      klass = LegacyBase.const_set(klass,Class.new(LegacyBase))

      klass.class_eval do
        @original_model_name =   original_model_constant
        self.table_name = model.tableize
      end
    end
  end

  def self.import_all
    create_legacy_models
    legacy_models = LegacyBase.descendants
    #ActiveRecord::Base.descendants.each {|c| [:create, :update].each {|e| c.reset_callbacks e }}
    #Model.class_eval do
    #  def run_validations!
    #    true
    #  end
    #end
    legacy_models.each do |legacy_model|
      begin
        import_status = legacy_model.count != legacy_model.original_model_name.count
        if import_status
          legacy_model.send :import
          puts "#{legacy_model.original_model_name.count} of #{legacy_model.count} records was imported"
          puts "#{legacy_model} was imported"
        else
          puts  "#{legacy_model} already has been imported"
        end
      rescue => e
        puts " error: #{e}"
        break
      end
    end
  end
end