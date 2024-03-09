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
end

def tax(category, imported)
  tax_rate = 0.0
  tax_rate += 0.05 if category == 'Fruit'
  tax_rate += 0.3 if category == 'Liquor'
  tax_rate += 0.12 if imported
  tax_rate
end

def import_duty(imported, price, quantity)
  imported ? price * quantity * 0.12 : 0
end

def cost(price, tax, import_duty, quantity)
  (price + (price * tax) + import_duty) * quantity
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
  total_price += cost(product.price, tax(product.category, product.imported), import_duty(product.imported, product.price, product.quantity), product.quantity)
end

if total_price > 500
  total_discount = total_price * 0.05
end

# Calculate the tax and cess
total_tax = 0.0
total_cess = 0.0

shopping_cart.each do |product|
  total_tax += cost(product.price, tax(product.category, product.imported), import_duty(product.imported, product.price, product.quantity), product.quantity) * tax(product.category, product.imported)
end

total_cess = total_tax * 0.04

# Calculate the grand total
grand_total = total_price - total_discount + total_tax + total_cess

# Display the selected products and total price
puts "Selected Products:"

shopping_cart.each do |product|
  puts "Name: #{product.name}"
  puts "Price: #{product.price}"
  puts "Tax: #{cost(product.price, tax(product.category, product.imported), import_duty(product.imported, product.price, product.quantity), product.quantity) * tax(product.category, product.imported)}"
  puts "Quantity: #{product.quantity}"
  puts "Cost: #{cost(product.price, tax(product.category, product.imported), import_duty(product.imported, product.price, product.quantity), product.quantity)}"
end

puts "Total Discount: Rs #{total_discount}"
puts "Total: Rs #{total_price}"
puts "Cess: Rs #{total_cess}"
puts "Grand Total: Rs #{grand_total}"
