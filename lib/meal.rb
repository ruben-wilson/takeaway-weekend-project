class Meal
  def initialize(description, price)
    @description = description 
    @price = price 
  end
  def description
   @description
  end 
  def price
    return "£#{@price}"
  end 
end 