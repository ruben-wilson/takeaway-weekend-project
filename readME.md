# {{Diary}} Multi-Class Planned Design Recipe

## 1. Describe the Problem
```
As a customer
So that I can check if I want to order something
I would like to see a list of dishes with prices.
 
_list of dishes + prices._

As a customer
So that I can order the meal I want
I would like to be able to select some number of several available dishes.

_add dishes to 'basket'._

As a customer
So that I can verify that my order is correct
I would like to see an itemised receipt with a grand total.

_receipt to be outputted with total prices for dishes._
```
## 2. Design the Class System

_Consider diagramming out the classes and their relationships. Take care to
focus on the details you see as important, not everything. The diagram below
uses asciiflow.com but you could also use excalidraw.com, draw.io, or miro.com_

![alt text](https://github.com/ruben-wilson/takeaway-weekend-project/blob/main/classDiagram.png)

_Also design the interface of each class in more detail._

```ruby
class CheckOut
  def input_menu(meals)#=> meals is a instance of meal 
    #=> creates a "menu" array of meals 
  end 
  def menu

    # returns meal description + price from meal array
  end 
  def basket
    #returns contents of basket as string 
  end
  def add_to_basket(meal) #meal is an instance of meal 

    #returns array of meal instances that user has #selected 
  end
  def remove_from_basket(meal)
    #=> removes meal from basket
  end 
  def receipt
   #@basket is an array of meals created by add_to_basket
   #returns dishes from basket with discription + price 
  end
  def time_of_arrival(number)#=> number is an interger representing users phone numbers
    #sends out an sms to users phone number
  end 
end 

class Meal
  def initialize(description, price)#desciption is what food it is 
                                   #price of food 
    #=> nil
  end
  def description
    #=> @description
  end 
  def price 
    #=> @price
  end 
end 
```

## 3. Create Examples as Integration Tests

_Create examples of the classes being used together in different situations and
combinations that reflect the ways in which the system will be used._

```ruby
# add meals to class during initalize 
checkout = CheckOut.new
meal = Meal.new("chicken and rice", "11.11")
meal2 = Meal.new("suasage and mash", "8.75")
meal3 = Meal.new("beans on toast", "19")
meal4 = Meal.new("steak and chips", "8.5")
meal5 = Meal.new("vegan stuff", "0.5")
checkout.input_menu(meal)
checkout.input_menu(meal2)
checkout.input_menu(meal3)
checkout.input_menu(meal4)
checkout.input_menu(meal5)
expect(checkout.menu) #=> "chicken and rice: £11.11, suasage and mash: £8.75, beans on toast: £19, steak and chips: £8.5, vegan stuff: £0.50"

# add meals to class during initalize but basket stays empty
checkout = CheckOut.new
meal = Meal.new("chicken and rice", "11.11")
meal2 = Meal.new("suasage and mash", "8.75")
meal3 = Meal.new("beans on toast", "19")
meal4 = Meal.new("steak and chips", "8.5")
meal5 = Meal.new("vegan stuff", "0.5")
checkout.input_menu(meal)
checkout.input_menu(meal2)
checkout.input_menu(meal3)
checkout.input_menu(meal4)
checkout.input_menu(meal5)
expect(checkout.basket) #=> "no items added to basket"


# add_to_basket adds instances of "meal" to the basket array
checkout = CheckOut.new
meal = Meal.new("chicken and rice", "11.11")
meal2 = Meal.new("suasage and mash", "8.75")
meal3 = Meal.new("beans on toast", "19")
meal4 = Meal.new("steak and chips", "8.5")
meal5 = Meal.new("vegan stuff", "0.5")
checkout.input_menu(meal)
checkout.input_menu(meal2)
checkout.input_menu(meal3)
checkout.input_menu(meal4)
checkout.input_menu(meal5)
checkout.add_to_basket(meal)
expect(checkout.basket) #=> "chicken and rice"

# add_to_basket adds multiply instances of "meal" to the basket array
checkout = CheckOut.new
meal = Meal.new("chicken and rice", "11.11")
meal2 = Meal.new("suasage and mash", "8.75")
meal3 = Meal.new("beans on toast", "19")
meal4 = Meal.new("steak and chips", "8.5")
meal5 = Meal.new("vegan stuff", "0.5")
checkout.input_menu(meal)
checkout.input_menu(meal2)
checkout.input_menu(meal3)
checkout.input_menu(meal4)
checkout.input_menu(meal5)
checkout.add_to_basket(meal)
checkout.add_to_basket(meal2)
expect(checkout.basket) #=> "chicken and rice, suasage and mash"

#basket is returned by recipet correctly
checkout = CheckOut.new
meal = Meal.new("chicken and rice", "11.11")
meal2 = Meal.new("suasage and mash", "8.75")
meal3 = Meal.new("beans on toast", "19")
meal4 = Meal.new("steak and chips", "8.5")
meal5 = Meal.new("vegan stuff", "0.5")
checkout.input_menu(meal)
checkout.input_menu(meal2)
checkout.input_menu(meal3)
checkout.input_menu(meal4)
checkout.input_menu(meal5)
checkout.add_to_basket(meal)
checkout.add_to_basket(meal2)
checkout.receipt #=> "chicken and rice: £11.11, suasage and mash: £8.75"

#remove_from_basket removes instance of meal correctly 
checkout = CheckOut.new
meal = Meal.new("chicken and rice", "11.11")
meal2 = Meal.new("suasage and mash", "8.75")
meal3 = Meal.new("beans on toast", "19")
meal4 = Meal.new("steak and chips", "8.5")
meal5 = Meal.new("vegan stuff", "0.5")
checkout.input_menu(meal)
checkout.input_menu(meal2)
checkout.input_menu(meal3)
checkout.input_menu(meal4)
checkout.input_menu(meal5)
checkout.add_to_basket(meal)
checkout.add_to_basket(meal2)
checkout.remove_from_basket(meal2)
checkout.basket #=> "chicken and rice"

#remove_from_basket removes all instances of meal(s) correctly 
checkout = CheckOut.new
meal = Meal.new("chicken and rice", "11.11")
meal2 = Meal.new("suasage and mash", "8.75")
meal3 = Meal.new("beans on toast", "19")
meal4 = Meal.new("steak and chips", "8.5")
meal5 = Meal.new("vegan stuff", "0.5")
checkout.input_menu(meal)
checkout.input_menu(meal2)
checkout.input_menu(meal3)
checkout.input_menu(meal4)
checkout.input_menu(meal5)
checkout.add_to_basket(meal)
checkout.add_to_basket(meal2)
checkout.remove_from_basket(meal2)
checkout.remove_from_basket(meal)
checkout.basket #=> "no items in the basket"

#remove_from_basket removes instance of meal correctly and then add_to_basket adds it back
checkout = CheckOut.new
meal = Meal.new("chicken and rice", "11.11")
meal2 = Meal.new("suasage and mash", "8.75")
meal3 = Meal.new("beans on toast", "19")
meal4 = Meal.new("steak and chips", "8.5")
meal5 = Meal.new("vegan stuff", "0.5")
checkout.input_menu(meal)
checkout.input_menu(meal2)
checkout.input_menu(meal3)
checkout.input_menu(meal4)
checkout.input_menu(meal5)
checkout.add_to_basket(meal)
checkout.add_to_basket(meal2)
checkout.remove_from_basket(meal2)
checkout.add_to_basket(meal2)
checkout.basket #=> "chicken and rice, sausage and mash"

#it sends message to user after recipet has been called 
checkout = CheckOut.new
meal = Meal.new("chicken and rice", "11.11")
meal2 = Meal.new("suasage and mash", "8.75")
checkout.input_menu(meal)
checkout.input_menu(meal2)
checkout.add_to_basket(meal)
checkout.add_to_basket(meal2)
expect(checkout.receipt) #=> "chicken and rice: £11.11, suasage and mash: 8.75"
expect(checkout.time_of_arrival) #=> "your food is coming at 22:55" 


```

## 4. Create Examples as Unit Tests
```ruby
# EXAMPLE
_meal_
#1 it initalizes corretly and returns description 
meal = Meal.new("chicken and rice", "11.50")
meal.description #=> "chicken and rice"

#2 it initializes correctly and retunrs price
meal = Meal.new("chicken and rice", "11.50")
meal.price #=> "£11.50"

_checkout_
#1 input_menu() adds meal instances and menu() returns it 
checkout = CheckOut.new
checkout.input_menu(meal("some meal"))
checkout.menu #=> "some meal"

#2 input_menu() adds multiply meals instances and menu() returns it 
checkout = CheckOut.new
checkout.input_menu(meal("some meal"))
checkout.input_menu(meal2("some more meals"))
checkout.menu #=> "some meal, some more meals"

#3 add_to_basket() adds meals to basket and basket() and returns it
checkout = CheckOut.new
checkout.input_menu(meal("some meal"))
checkout.input_menu(meal2("some more meals"))
checkout.add_to_basket(meal)
checkout.basket #=> "some meal" 

#4 remove_from_basket removes item from basket after item is added 
checkout = CheckOut.new
checkout.input_menu(meal("some meal"))
checkout.input_menu(meal2("some more meals"))
checkout.add_to_basket(meal)
checkout.remove_from_basket(meal)
checkout.basket #=> "no items added to your basket"

#5 remove_from_basket throws fault when no items are in basket 
checkout = CheckOut.new
checkout.input_menu(meal("some meal"))
checkout.input_menu(meal2("some more meals"))
checkout.remove_from_basket(meal)
checkout.basket #=> FAIL 


#5 remove_from_basket throws fault when item is not in basket 
checkout = CheckOut.new
checkout.input_menu(meal("some meal"))
checkout.input_menu(meal2("some more meals"))
checkout.add_to_basket(meal2)
checkout.remove_from_basket(meal)
checkout.basket #=> FAIL 

#6 receipt correctly outputs basket descriptions and prices of meal instances  
checkout = CheckOut.new
checkout.input_menu(meal("some meal", "11"))
checkout.input_menu(meal2("some more meals", "14"))
checkout.add_to_basket(meal)
checkout.add_to_basket(meal2)
checkout.receipt #=> "some meal: £11, some more meals: £14"
```

_Encode each example as a test. You can add to the above list as you go._

## 5. Implement the Behaviour

_After each test you write, follow the test-driving process of red, green,
refactor to implement the behavior._

## 6. test edge cases in unit test 



## 7. test edge cases in integration test

## 8. improvements + new features 

- add in text feature using twilo 

```ruby 
#6 receipt correctly outputs basket descriptions and prices of meal instances  
checkout = CheckOut.new
checkout.input_menu(meal("some meal", "11"))
checkout.input_menu(meal2("some more meals", "14"))
checkout.add_to_basket(meal)
checkout.add_to_basket(meal2)
checkout.receipt #=> "some meal: £11, some more meals: £14"

```

- recipet should return total price 
