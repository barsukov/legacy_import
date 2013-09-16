require "rspec_helper"
require "generator_spec"

describe ConfigOfLegacy do
    destination File.expand_path("../../tmp", __FILE__)
    arguments %w(something)

    before(:all) do
      prepare_destination
      run_generator
    end

    it "creates a test initializer" do
      assert_file "config/initializers/legacy_import.rb", "# Initializer"
    end
end
