require 'rails_helper'

describe 'meal management', type: :feature do
  before(:each) do
    login_user
    create_schedule
    visit user_root_path
    MealCategory.create(name: "Vegetarian")
    MealCategory.create(name: "Chicken")
    page.click_link('Week details', match: :first)
    page.click_link('Add my meal')
  end

  it "can make a meal" do
    week = @group.weeks.first
    expect(current_path).to eq(new_group_week_meal_path(@group.name, week))
    expect(page).to have_content("Recipe url")
    expect(page).to have_content("Category")

    page.fill_in('meal[name]', with: "Meatball Subs")
    page.fill_in('meal[recipe_url]', with: "www.meatballsub.com")
    select('Chicken', :from => 'meal[meal_category_id]')
    page.click_button("Add meal")

    meal = week.meals.first
    expect(current_path).to eq(group_week_meal_path(@group.name, week, meal))
    expect(page).to have_content("Meatball Subs")
    expect(page).to have_content("Chicken")
    expect(meal.recipe_url).to eq("www.meatballsub.com")
  end

  it "can't make a meal without selecting a category" do
    page.fill_in('meal[recipe_url]', with: "www.meatballsub.com")
    select('Chicken', :from => 'meal[meal_category_id]')
    page.click_button("Add meal")
    week = @group.weeks.first

    expect(current_path).to eq(new_group_week_meal_path(@group.name, week))
    expect(page).to have_content("Please select a category and add your meal")
  end
end