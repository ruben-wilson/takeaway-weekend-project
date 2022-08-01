require "meal"
require "checkout"

RSpec.describe "intergration tests" do 
  it "add meals to class during initalize" do 
    checkout = CheckOut.new
    meal = Meal.new("chicken and rice", "11.11")
    meal2 = Meal.new("suasage and mash", "8.75")
    meal3 = Meal.new("beans on toast", "19")
    meal4 = Meal.new("steak and chips", "8.5")
    meal5 = Meal.new("vegan stuff", "0.50")
    checkout.input_menu(meal)
    checkout.input_menu(meal2)
    checkout.input_menu(meal3)
    checkout.input_menu(meal4)
    checkout.input_menu(meal5)
    expect(checkout.menu).to eq "chicken and rice: £11.11, suasage and mash: £8.75, beans on toast: £19, steak and chips: £8.5, vegan stuff: £0.50"
  end
end 
