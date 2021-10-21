require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature do
  
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        quantity: 10,
        price: 64.99
      )
    end

    
  end
  
  scenario "users can click the 'Add to Cart' button for a product on the home page" do
    # ACT
    visit root_path 
    first('.product').click_button('Add')
    expect(page).to have_content 'My Cart (1)'
    puts page.html
  end

end
