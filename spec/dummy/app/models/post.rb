class Post < ActiveRecord::Base
  belongs_to :blog
  attr_accessible :content, :name, :title
end
