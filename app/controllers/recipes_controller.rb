class RecipesController < ApplicationController
    before_action :find_recipe, only: [:show, :edit,:destroy, :update,:add_category] 
    before_action :authenticate_user!, only: [:new, :edit]
    def index
        @recipes=Recipe.all
    end
    
    def new
        @recipe= current_user.recipes.new
    end
    
    def create
        @recipe = current_user.recipes.new(recipe_params)
        add_category
        
        if @recipe.save
            redirect_to recipes_path
        else
            render 'new'
        end
    end
    
    def show
        @reviews = @recipe.reviews.to_a
        if @reviews.blank?
            @avg_rating = 0 
        else
            @avg_rating= @recipe.reviews.average(:rating).round(2)
        end
    end
    def destroy
        @recipe.destroy
        redirect_to recipes_path
    end
    def edit
        @categories=Category.all.map{|c| [c.name, c.id]}
    end
    
    def update 
        add_category
        if @recipe.update_attributes(recipe_params)
            redirect_to @recipe
        else
            render 'edit'
        end
    end
    
    def find_recipe
        @recipe = Recipe.find(params[:id])
        
    end
    # strong parameters
    def recipe_params
        
        params.require(:recipe).permit(:title, :description, :publisher, :recipe_img)
    end
    def add_category
        
        @recipe.categories=[]
        @category_ids= params[:recipe][:category_ids].delete_if{|i|i==""}
        @category_ids.each do |c|
            @category = Category.find(c) 
            @recipe.categories << @category if (@recipe.categories.include?(@category)==false)
        end
        
    end
    def recipes_by_category
        Category.all.each {|c| @category= c if params[:category_name]==c.name}
    end
    
end


#Parameters: {"utf8"=>"✓", "authenticity_token"=>"PA6WpN9vY+CbdpjyPntZeTWZ3BIPJwm1It8trF/MlXCaB0cHkOWebVZFE0kSq8EJS0Z/tQWKpyYUKwniMYN7Dg==", "recipe"=>{"title"=>"chicken", "description"=>"pollo frito", "publisher"=>"cubano"}, "commit"=>"Submit"}
#params is a built in hash that takes whatsever in your route and put in a hash
#params is a hash with recipe key and another hash in the value with the title description and publisher