require 'rails_helper'

RSpec.describe MealCategory, type: :model do
  it "exists" do
    category = create(:meal_category)

    expect(category).to be_valid
    expect(category.name).to eq("Pork")
  end
end
