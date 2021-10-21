require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature do

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
  
  scenario "Description is visible after clicking on a button" do
    # ACT
    visit root_path 
    first('.product').click_link('Details')
    expect(page).to have_content 'Description'
    puts page.html
  end

end
