require 'sendSms'

class CheckOut
  def initialize 
    @menu = []
    @basket = []
  end 

  def input_menu(meal)
    @menu << meal
  end 

  def menu
    output = []
    @menu.each {|meal|
      output << "#{meal.description}: #{meal.price}"
    }
    output.join(", ")
    # returns meal description + price from meal array
  end 
  
  def basket 
    output = []
    @basket.each{ |meal|
      output << meal.description
    }
    if output.join(", ") == ""
      return "no items added to your basket"
    else
      return output.join(", ")
    end  
  end

  def add_to_basket(meal)
    @basket << meal  
  end

  def remove_from_basket(meal_to_remove)
    found = false
    @basket.each{ |meal|
      if meal.description == meal_to_remove.description
        @basket.delete(meal)
        found = true 
      end 
    }
    fail "item cannont be found in basket" if !found 
  end 
  
  def receipt
   output = []
    @basket.each{ |meal|
      output << "#{meal.description}: #{meal.price}"
    }
    if output.join(", ") == ""
      return "no items added to your basket"
    else
      return output.join(", ")
    end
  end 
    
    def time_of_arrival
      message = sendSms.new
      message.send 
    end 
  
end 