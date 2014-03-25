# LegacyModel config file. Generated on December 17, 2013 20:08
# See github.com/barsukov/legacy_import for more informations

LegacyImport.config do |config|
    #Model need to be import
    config.acceptable_models = [Blog,Post]

    config.legacy_model Blog do |mode|
      table_name = "blogs"
    end

    #TestModel
    #TestModel::MyNestedModel

    #Model which to be ignored for import if you need test it
    config.ignored_models = []
end






