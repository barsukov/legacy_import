require "rspec"
require "legacy_import.rb"
require "legacy_import/legacy_importer"

describe "LegaceImporter" do
      describe "get_models" do
      context 'when we need a get acceptance models' do
        before { LegacyImporter.set_config_imported_models "#{LegacyImport.dummy}/config/initializers/import_models.yml"}
        let(:all_models) {LegacyImporter.get_all_models }
        let(:acceptance_models) {LegacyImporter.get_only_acceptance_model }

        it 'has collection of models' do
          all_models.count.should > 0
        end

        it 'collection has only acceptance models' do
          acceptance_models.count < all_models.count
        end
      end
    end

    describe ".get_special_parameters" do
      context "validation off parameter for model" do

      end
      context "nested model parameter" do

      end
      context ""
    end

    describe ".create_models" do

    end
end