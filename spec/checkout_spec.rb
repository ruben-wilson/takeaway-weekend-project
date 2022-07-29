require "checkout"

RSpec.describe CheckOut do 
  it "#1 input_menu() adds meal instances and menu() returns it" do 
    checkout = CheckOut.new
    meal = double(:meal, description: "some meal", price: "£11.50")
    checkout.input_menu(meal)
    expect(checkout.menu).to eq "some meal: £11.50"
  end
  it "#2 input_menu() adds multiply meals instances and menu() returns it" do 
    checkout = CheckOut.new
    meal = double(:meal, description: "some meal", price: "£11.50")
    meal2 = double(:meal, description: "some more meals", price: "£31.50")
    checkout.input_menu(meal)
    checkout.input_menu(meal2)
    expect(checkout.menu).to eq "some meal: £11.50, some more meals: £31.50"
  end
  it "#3 add_to_basket() adds meal to basket and basket() and returns it" do 
    checkout = CheckOut.new
    meal = double(:meal, description: "some meal", price: "£11.50")
    meal2 = double(:meal, description: "some more meals", price: "£31.50")
    checkout.input_menu(meal)
    checkout.input_menu(meal2)
    checkout.add_to_basket(meal)
    expect(checkout.basket).to eq "some meal"
  end
  it "#3.5 add_to_basket() adds meal(s) to basket and basket() and returns it" do 
    checkout = CheckOut.new
    meal = double(:meal, description: "some meal", price: "£11.50")
    meal2 = double(:meal, description: "some more meals", price: "£31.50")
    checkout.input_menu(meal)
    checkout.input_menu(meal2)
    checkout.add_to_basket(meal)
    checkout.add_to_basket(meal2)
    expect(checkout.basket).to eq "some meal, some more meals"
  end
  it "#4 remove_from_basket removes item from basket after item is added " do 
    checkout = CheckOut.new
    meal = double(:meal, description: "some meal", price: "£11.50")
    meal2 = double(:meal, description: "some more meals", price: "£31.50")
    checkout.input_menu(meal)
    checkout.input_menu(meal2)
    checkout.add_to_basket(meal)
    checkout.remove_from_basket(meal)
    expect(checkout.basket).to eq "no items added to your basket"
  end
  it "#5 remove_from_basket throws fault when no items are in basket" do 
    checkout = CheckOut.new
    meal = double(:meal, description: "some meal", price: "£11.50")
    meal2 = double(:meal, description: "some more meals", price: "£31.50")
    checkout.input_menu(meal)
    checkout.input_menu(meal2)
    expect{checkout.remove_from_basket(meal)}.to raise_error("item cannont be found in basket")
  end
  it "#5.5 remove_from_basket throws fault when no items are in basket" do 
    checkout = CheckOut.new
    meal = double(:meal, description: "some meal", price: "£11.50")
    meal2 = double(:meal, description: "some more meals", price: "£31.50")
    checkout.input_menu(meal)
    checkout.input_menu(meal2)
    checkout.add_to_basket(meal2)
    expect{checkout.remove_from_basket(meal)}.to raise_error("item cannont be found in basket")
  end
  it "#6 receipt correctly outputs basket descriptions and prices of meal instances" do 
    checkout = CheckOut.new
    meal = double(:meal, description: "some meal", price: "£11.50")
    meal2 = double(:meal, description: "some more meals", price: "£31.50")
    checkout.input_menu(meal)
    checkout.input_menu(meal2)
    checkout.add_to_basket(meal)
    checkout.add_to_basket(meal2)
    expect(checkout.receipt).to eq "some meal: £11.50, some more meals: £31.50"
  end
end 



