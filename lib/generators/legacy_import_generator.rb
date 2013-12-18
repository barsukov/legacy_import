class LegacyImportGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  argument :config_name, :type => :string, :default => "legacy_import"

  desc "LegacyImport installation generator"
  def generate_legacy_import
    initializer = (File.open(Rails.root.join("config/initializers/legacy_import.rb")) rescue nil).try :read

    unless initializer
      template "initializer.erb", "config/initializers/legacy_import.rb"
    else
      template "initializer.erb", "config/initializers/legacy_import.rb.example"
      #display "You already have a config file. You're updating, heh? I'm generating a new 'import_models.rb.example' that you can review."
    end
  end
end
