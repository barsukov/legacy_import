require 'factory_girl'

Dir[Rails.root.join("spec/factories/*.rb")].each {|f| require f}


FactoryGirl.create_list(:blog_with_posts, 15,posts_count: 15)
