require "rspec"

describe "LegaceImporter" do
    before do
      require "lib/legacy_import/legacy_importer"
    end

    describe "get_models" do

      context 'when updates a not existing property value' do
        let(:all_models) { LegacyImporter.imported_models }
        let(:acceptance_models) {LegacyImporter.get_only_acceptance_model }

        it 'has collection of models' do
          all_models.count.should > 0
        end

        it 'collection has only acceptance models' do
          acceptance_model.count < all_models.count
        end
      end
    end

    describe ".create_models" do

    end
end