require 'rails_helper'

RSpec.describe Review, type: :model do

  it "belongs to a user and a meal" do
    user = create(:user)
    meal = create(:meal)
    review = create(:review)
    user.reviews << review
    meal.reviews << review

    expect(user.reviews.first.id).to eq(review.id)
    expect(meal.reviews.first.id).to eq(review.id)
  end
end