class Recipe < ActiveRecord::Base
    belongs_to :user
    has_and_belongs_to_many :categories
    has_many :reviews
   
    has_attached_file :recipe_img, default_url: "/images/:style/missing.png"
    validates_attachment_content_type :recipe_img, content_type: /\Aimage\/.*\Z/
end
