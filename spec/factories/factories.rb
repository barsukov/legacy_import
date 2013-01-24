FactoryGirl.define do

  factory :blog do
    sequence(:title) {|n| "blog_tittle #{n}" }
    sequence(:name) {|n| "blog_name #{n}" }

    factory :blog_with_posts do
      ignore do
        posts_count 5
      end


      after(:create) do |blog, evaluator|
        FactoryGirl.create_list(:post, evaluator.posts_count, blog: blog)
      end
    end
  end

  factory :post do
    blog
    sequence(:title) {|n| "post_tittle #{n}" }
    sequence(:name) {|n| "post_name #{n}" }
    sequence(:content) {|n| "post_content #{n}" }
    end
end