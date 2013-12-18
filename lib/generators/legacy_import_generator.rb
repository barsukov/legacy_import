class LegacyImportGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  desc "LegacyImport installation generator"
  def install
    initializer = (File.open(Rails.root.join("config/initializers/legacy_import.rb")) rescue nil).try :read

    unless initializer
      template "initializer.erb", "config/initializers/impor.yml"
    else
      display "You already have a config file. You're updating, heh? I'm generating a new 'import_models.yml.example' that you can review."
      template "initializer.erb", "config/initializers/legacy_import.rb.example"
    end
  end
end
