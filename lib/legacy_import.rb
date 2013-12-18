require "legacy_import/version"
require 'legacy_import/config'

module LegacyImport
  def self.root
    File.expand_path '../..', __FILE__
  end
  def self.dummy
    File.join root, 'spec/dummy'
  end
  def self.config(&block)
    if block_given?
      block.call(LegacyImport::Config)
    else
      LegacyImport::Config
    end
  end
end