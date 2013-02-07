# encoding: utf-8
namespace :app do

  desc "Legacy import data from your legacy database to real database"
  task :legacy_import => :environment do
    require "legacy_import/legacy_importer"
    begin
    config_models ="#{Rails.root}/config/initializers/import_models.yml"
    LegacyImporter.set_config_imported_models config_models
    LegacyImporter.import_all
    puts  "Mohito!"
    rescue => e
      puts " error: #{e}"
    end
  end

end
