require 'rails_helper'
require 'devise'
require 'byebug'


RSpec.describe RecipesController, type: :controller do

    describe "GET index" do
         #before(:each) do
           # user = build(:user)
        #end
        it 'correctly sets up @recipes for the view' do
            
            r = create(:recipe)
            r2 = create(:recipe)
            get :index

            expect(assigns[:recipes]).to eq([r, r2])
        end
    end

   
    describe 'GET #new' do
       
        before(:each) do
            user=create(:user)
            sign_in(user)
            #category=create(:category) 
            get :new
            
        end
     
        it "creates a new recipe" do
           
            expect(assigns[:recipe]).to be_a_new(Recipe) # assigns is a hash of instance variable
        end
    end
    

    describe "RECIPE create" do
        before(:each) do
            user=create(:user)
            sign_in(user)
            @category=create(:category)
        end
        let(:r) { create(:recipe)} 
        
        let(:recipe_params) { attributes_for(:recipe, category_ids:[@category.id])} #using the FactoryGirl to make a hash

        it "creates a new recipe" do
           
            expect{ post(:create, {recipe: recipe_params}) }.to change { Recipe.count }.by 1 # post match with the HTTP POST request
            
        end                                                                                  #and go to the controller create action

        it "creates a recipe with correct title, description and publisher" do
            
            post(:create , {recipe: recipe_params})
            @recipe = Recipe.last
            expect(@recipe.description).to eq(recipe_params[:description])
            expect(@recipe.title).to eq(recipe_params[:title])
            expect(@recipe.publisher).to eq(recipe_params[:publisher])
        end
        
        it "redirects to the correct url" do
            post(:create , {recipe: recipe_params})
            expect(response).to redirect_to recipes_path
        end

    end

    describe "Edit recipe" do
        let(:r) { create(:recipe) }

        before(:each) do  #before(:each) runs the block one time before each of the specs in the file
            get :edit, id: r.id
        end
        
        it "finds a specific item" do
            expect(assigns[:recipe]).to eq(r)
        end
    end

  
    describe "Update Recipe" do
        before(:each) do
            user=create(:user)
            sign_in(user)
            @category=create(:category)
        end
        let(:r) { create(:recipe, title:"Updated title") }
        let(:recipe_params) { attributes_for(:recipe, category_ids:[@category.id], title: "Updated title")}
        
        it "updates a recipe with valid params" do
            post :update, id: r.id, recipe: recipe_params
            r.reload
            expect(r.title).to eq("Updated title")
        end
    end
    
    describe "DELETE destroy" do
        let(:r) { create(:recipe) }

        it 'destroys recipe' do
            expect(r.persisted?).to eq(true)
            expect{ delete(:destroy, {id: r.id})}.to change { Recipe.count}.by (-1)
        end
    end
    
    
end

