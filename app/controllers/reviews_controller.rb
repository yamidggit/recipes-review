class ReviewsController < ApplicationController
    before_action :find_recipe
    before_action :find_review, only: [:edit, :update, :destroy ]
    before_action :authenticate_user!, only: [:new, :edit]
    def new
        @review=Review.new
        
    end
    
    def create
        @review = current_user.reviews.new(review_params) 
        @review.recipe_id= @recipe.id
        if (@review.save) 
           redirect_to recipe_path(@recipe)
        else
            render 'new'
        end 
    end
    
    def edit
        
    end
    
    def update
        
        if @review.update_attributes(review_params)
            redirect_to recipe_path(@recipe)
        else
            render 'edit'
        end
    end
    
    def destroy
        @review.destroy
        redirect_to recipe_path(@recipe)
    end
    
    def find_recipe
        @recipe = Recipe.find(params[:recipe_id])
        
    end
    
    def find_review
        @review = Review.find(params[:id])
        
    end

    def review_params
        params.require(:review).permit(:rating, :comment)
    end
end
