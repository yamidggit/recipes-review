require 'rails_helper'


RSpec.describe Recipe do

    let(:recipe) { create(:recipe) }

    it 'has title, description and publisher' do
        expect(recipe.title).to_not be_nil
        expect(recipe.description).to_not be_nil
        expect(recipe.publisher).to_not be_nil
    end
end