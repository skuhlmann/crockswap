require 'rails_helper'

RSpec.describe Week, type: :model do
  it "exists" do
    week = create(:week)
    start = Date.parse('2016-06-25')

    expect(week).to be_valid
    expect(week.start_date).to eq(start)
  end

  it "can belongs to  a group" do
    week = create(:week)
    group = create(:group)
    group.weeks << week

    expect(group.weeks.first.id).to eq(week.id)
  end

  it "knows it's available categories" do
    week = create(:week)
    group = create(:group)
    meal = create(:meal)
    group.weeks << week
    week.meals << meal

    category = create(:meal_category)
    next_category = MealCategory.create(name: "Beef")
    
    expect(week.available_categories.count).to eq(2)
    expect(week.available_categories[0]).to eq(category)

    meal.category = category
    meal.save

    expect(week.available_categories.count).to eq(1)
    expect(week.available_categories[0]).to eq(next_category)
  end
end
