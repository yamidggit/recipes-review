class ReviewsController < ApplicationController
     before_action :find_recipe, only: [:show, :edit,:destroy, :update,:add_category] 
    def new
        @review=current_user.reviews.new
    end
    def create
        @review = current_user.reviews.new(review_params)
        if (@review.save) 
          current_user.recipes.each do|r|
          @recipe=r if (r.id == @review.recipe_id)
         end
          
           redirect_to recipe_path(@recipe)
        else
            render 'new'
        end
         
    end
    
    def edit
    end
    def update
    end
    def destroy
    end
    def find_recipe
        current_user.recipes.each {|r| @recipe=r if r.id==@review.recipe_id} 
    end
    def find_review
        @review=Review.find(params[:id])
    end
    def review_params
        params.require(:review).permit(:rating, :comment)
    end
end
