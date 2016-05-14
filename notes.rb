Model 
Recipes
User
Categories
Review


Recipes
    belong to user 
    has_and_belongs_to_many categories
    have many reviews
    
User
    have many recipes



Categories
    has_and_belongs_to_many recipes
    
Review 
    belongs to recipe 
    belongs to user
    
    
    <%= select_tag :category_id, options_for_select(@categories), :prompt=> "Select a Category" %>
    belongs to user


Paperclip to attach images to the recipe:


Here are the steps that worked for me:

1. Update apt-get packages inside the C9 terminal

$ sudo apt-get update 
2. Install imagemagick command-line tools via apt-get

 run which convert (one of the ImageMagick utilities).
 This will give you the path where that utility is installed. 
 For example, it might return /usr/local/bin/convert.
 
 In development mode, you might add this line to config/environments/development.rb):

Paperclip.options[:command_path] = "/usr/local/bin/"


add this inside Model Recipe
    has_attached_file :recipe_img, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
    validates_attachment_content_type :recipe_img, content_type: /\Aimage\/.*\Z/
    
Rails migration generator: rails generate paperclip Recipe recipe_img    
rake db:migrate
    
    
   