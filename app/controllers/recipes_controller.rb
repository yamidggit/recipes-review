class RecipesController < ApplicationController
    before_action :find_recipe, only: [:show, :edit,:destroy, :update] 
    def index
        @recipes=Recipe.all
    end
    
    def new
        @recipe= Recipe.new
    end
    
    def create
        #puts "#{params.inspect}"
        @recipe = Recipe.new(recipe_params)
        if @recipe.save
            redirect_to recipes_path
        else
            render 'new'
        end
    end
    
    def show
        
    end
    def destroy
        @recipe.destroy
        redirect_to recipes_path
    end
    def edit
    end
    
    def update 
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
        params.require(:recipe).permit(:title, :description, :publisher)
    end
end


#Parameters: {"utf8"=>"✓", "authenticity_token"=>"PA6WpN9vY+CbdpjyPntZeTWZ3BIPJwm1It8trF/MlXCaB0cHkOWebVZFE0kSq8EJS0Z/tQWKpyYUKwniMYN7Dg==", "recipe"=>{"title"=>"chicken", "description"=>"pollo frito", "publisher"=>"cubano"}, "commit"=>"Submit"}
#params is a hash with recipe key and another hash in the value with the title description and publisher