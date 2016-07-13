class ReviewsController < ApplicationController
    before_action :find_recipe, only: [ :new, :edit,:update,] 
    before_action :find_review, only: [:edit, :update, :destroy ]
    before_action :authenticate_user!, only: [:new, :edit]
    def new
        @review=Review.new
        
    end
    
    def create
        if user_signed_in?
            @review = current_user.reviews.new(review_params) 
        else
             @review = Review.new(review_params) 
        end
        @review.recipe_id= params[:recipe_id]
        if (@review.save) 
           redirect_to recipe_path(params[:recipe_id])
        else
            render 'new'
        end 
    end
    
    def edit
        
    end
    
    def update
        
        if @review.update_attributes(review_params)
            redirect_to recipe_path(params[:recipe_id])
        else
            render 'edit'
        end
    end
    
    def destroy
        @review.destroy
        redirect_to recipe_path(params[:recipe_id])
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
