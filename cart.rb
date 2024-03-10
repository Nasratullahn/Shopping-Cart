class Cart
  require_relative "item.rb"
  def initialize(items)
    @items = items
  end
  attr_accessor :items
end
