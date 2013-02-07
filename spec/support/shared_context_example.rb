require 'spec_helper'

shared_context "load_and_parse_configuration" do
  before { LegacyImporter.set_config_imported_models "#{LegacyImport.dummy}/config/initializers/import_models.yml"}
  let(:all_models) {LegacyImporter.get_all_models }
  let(:acceptance_models) {LegacyImporter.get_only_acceptance_model }
end