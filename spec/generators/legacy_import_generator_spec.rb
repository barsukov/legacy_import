require 'spec_helper'

describe 'LegacyImport::LegacyImportGenerator' do
  context "with no arguments or options" do
    it "should generate a LegacyImport" do
      subject.should generate "config/initializers/legacy_import.rb"
    end
  end
end
