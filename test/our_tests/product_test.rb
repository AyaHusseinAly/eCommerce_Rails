require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  def setup
    @product1 = Product.new(title: "Product 1",description: 'description',price: 500)
    @product2 = Product.new(description: 'description',price: 100)
    @product3 = Product.new(title: "Product 3",price: 500)
    @product4 = Product.new(title: "Product 4",description: 'description')

  end

  test "should be valid" do
    assert @product1.valid?
  end
  test "should have title" do
    assert_not @product2.valid?
    assert_not @product2.save
  end
  test "should have description" do
    assert_not @product3.valid?
    assert_not @product3.save
  end
  test "should have price" do
    assert_not @product4.valid?
    assert_not @product4.save
  end
end
