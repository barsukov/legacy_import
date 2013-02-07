require "legacy_import/version"

module LegacyImport
  def self.root
    File.expand_path '../..', __FILE__
  end
  def self.dummy
    File.join root, 'spec/dummy'
  end
end
