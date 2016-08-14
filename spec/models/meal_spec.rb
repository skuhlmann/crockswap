require 'rails_helper'

RSpec.describe Meal, type: :model do
  it "exists" do
    meal = create(:meal)

    expect(meal).to be_valid
    expect(meal.name).to eq("Hot Dogs")
    expect(meal.freezable).to be
  end

  it "belongs to a user" do
    meal = create(:meal)
    user = create(:user)
    user.meals << meal

    expect(user.meals.first.id).to eq(meal.id)
  end

  it "belongs to a week" do
    meal = create(:meal)
    week = create(:week)
    week.meals << meal

    expect(week.meals.first.id).to eq(meal.id)
  end

  it "has a category" do
    meal = create(:meal)
    category = create(:meal_category)
    meal.category = category
    meal.save

    expect(meal.category.id).to eq(category.id)
  end

  it "has ratings" do
    meal = create(:meal)
    rating = create(:meal_rating)
    meal.ratings << rating

    expect(meal.ratings.first.id).to eq(rating.id)
  end
end
