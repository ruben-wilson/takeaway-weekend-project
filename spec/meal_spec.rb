require "meal"

RSpec.describe Meal do 
  it "it initializes corretly and returns description" do 
    meal = Meal.new("chicken and rice", "11.50")
    expect(meal.description).to eq "chicken and rice"
  end
  it "it initializes corretly and returns price" do 
    meal = Meal.new("chicken and rice", "11.50")
    expect(meal.price).to eq "£11.50"
  end 
end 
