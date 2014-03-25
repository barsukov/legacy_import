require "rspec"
require 'spec_helper'
#require "legacy_import/legacy_importer"
#require "legacy_import"

describe LegacyImporter do
    describe "get_models" do
      context 'when we need a get acceptance models' do

        let(:acceptance_models) {LegacyImporter.get_only_acceptance_model }
        let(:ignored_models) {LegacyImporter.get_only_ignored_model }

        it 'has collection with acceptable models' do
          acceptance_models.count.should > 0
        end

        it 'collection has only ignored models' do
          ignored_models.count == 0
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

    describe ".create_legacy_models" do
      context "create legacy classes" do
        it "with prefix legacy" do

        end

        it "has based on active record" do

        end

        it
      end
    end
end