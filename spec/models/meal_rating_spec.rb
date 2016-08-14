require 'rails_helper'

RSpec.describe MealRating, type: :model do
  it "exists" do
    rating = create(:meal_rating)

    expect(rating).to be_valid
    expect(rating.comment).to eq("Too Salty!")
    expect(rating.rating).to eq(3)
  end
end
