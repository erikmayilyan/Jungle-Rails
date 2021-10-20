require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    it 'is not valid without a name' do
      @category = Category.new(name: "Computers")
      @product = Product.new(name: nil, price: 500, quantity: 10, category: @category)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include "Name can't be blank"
    end

    it 'is not valid without a price' do
      @product = Product.new(name: "Computers", price_cents: nil, quantity: 10, category: @category)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include "Price can't be blank"
    end

    it 'is not valid without a quantity' do
      @product = Product.new(name: "Computers", price_cents: 500, quantity: nil, category: @category)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include "Quantity can't be blank"
    end

    it 'is not valid without a quantity' do
      @product = Product.new(name: "Computers", price_cents: 500, quantity: 10, category: nil)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include "Category can't be blank"
    end

  end
end