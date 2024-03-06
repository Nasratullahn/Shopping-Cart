# Define the Product class
class Product
  attr_accessor :name, :price, :quantity, :category, :imported

  def initialize(name, price, quantity, category, imported)
    @name = name
    @price = price
    @quantity = quantity
    @category = category
    @imported = imported
  end

  def tax
    tax_rate = 0.0
    tax_rate += 0.05 if category == 'Fruit'
    tax_rate += 0.3 if category == 'Liquor'
    tax_rate += 0.12 if imported
    tax_rate
  end

  def import_duty
    imported ? price * quantity * 0.12 : 0
  end

  def cost
    (price + (price * tax) + import_duty) * quantity
  end
end

# Initialize an empty shopping cart
shopping_cart = []

# Prompt the user for product inputs
puts "Enter the products you want to add to the shopping cart (one product per line):"
puts "Each product should be entered in the following format: Name Price Quantity Category Imported (separated by spaces)"
puts "Press Enter on an empty line to finish adding products."

loop do
  input = gets.chomp
  break if input.empty?

  product_info = input.split(' ')
  name = product_info[0]
  price = product_info[1].to_f
  quantity = product_info[2].to_i
  category = product_info[3]
  imported = product_info[4] == 'true'

  product = Product.new(name, price, quantity, category, imported)
  shopping_cart << product
end

# Calculate the total price and discounts
total_price = 0.0
total_discount = 0.0

shopping_cart.each do |product|
  total_price += product.cost
end

if total_price > 500
  total_discount = total_price * 0.05
end

# Calculate the tax and cess
total_tax = 0.0
total_cess = 0.0

shopping_cart.each do |product|
  total_tax += product.cost * product.tax
end

total_cess = total_tax * 0.04

# Calculate the grand total
grand_total = total_price - total_discount + total_tax + total_cess

# Display the selected products and total price
puts "Selected Products:"
shopping_cart.each do |product|
  puts "Name: #{product.name}"
  puts "Price: #{product.price}"
  puts "Tax: #{product.cost * product.tax}"
  puts "Quantity: #{product.quantity}"
  puts "Cost: #{product.cost}"
end

puts "Total Discount: Rs #{total_discount}"
puts "Total: Rs #{total_price}"
puts "Cess: Rs #{total_cess}"
puts "Grand Total: Rs #{grand_total}"
