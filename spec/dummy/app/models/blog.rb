class Blog < ActiveRecord::Base
  has_many :posts
  attr_accessible :name, :title
end
