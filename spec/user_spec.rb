require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    # validation examples here
    it "will create a user with password" do
      @user = User.new(first_name: "Erik", last_name: "Mayilyan", email: "mayilyane9@gmail.com", password: "123456", password_confirmation: "123456")
      expect(@user).to be_valid
    end

    it "will not create a user with password confirmation" do
      @user = User.new(first_name: "Erik", last_name: "Mayilyan", email: "mayilyane9@gmail.com", password: "123", password_confirmation: "345")
      expect(@user).to_not be_valid
    end

    it "will not create a user when password is nil" do
      @user = User.new(first_name: "Erik", last_name: "Mayilyan", email: "mayilyane9@gmail.com", password: nil, password_confirmation: "123")
      expect(@user.password).to be_nil
    end

    it "will not create a user when password confirmation is nil" do
      @user = User.new(first_name: "Erik", last_name: "Mayilyan", email: "mayilyane9@gmail.com", password: "123", password_confirmation: nil)
      expect(@user.password_confirmation).to be_nil
    end

    it "will not create a user when the email is taken (first case)" do
      @user = User.create(first_name: "Erik", last_name: "Mayilyan", email: "mayilyane9@gmail.com", password: "123456", password_confirmation: "123456")
      @userTwo = User.create(first_name: "Erik", last_name: "Mayilyan", email: "mayilyane9@gmail.com", password: "123456", password_confirmation: "123456")
      @userTwo.validate
      expect(@userTwo.errors.full_messages.length).to eq(1)
      expect(@userTwo).to_not be_valid
      expect(@user.errors.full_messages.length).to eq(0)
      expect(@user).to be_valid
    end

    it "will not create a user when the email is taken (second case)" do
      @user = User.create(first_name: "Erik", last_name: "Mayilyan", email: "mayilyane9@gmail.com", password: "123456", password_confirmation: "123456")
      @userTwo = User.create(first_name: "Erik", last_name: "Mayilyan", email: "MAyiLYaNe9@GMaIl.cOm", password: "123456", password_confirmation: "123456")
      @userTwo.validate
      expect(@userTwo).to_not be_valid
      expect(@user.errors.full_messages.length).to eq(0)
      expect(@user).to be_valid
    end

    it "will require the email" do 
      @user = User.create(first_name: "Erik", last_name: "Mayilyan", password: "123", password_confirmation: "123")
      expect(@user).to_not be_valid
    end

    it "will require the first name" do 
      @user = User.create(last_name: "Mayilyan", email: "mayilyane9@gmail.com", password: "123", password_confirmation: "123")
      expect(@user).to_not be_valid
    end

    it "will require the last name" do 
      @user = User.create(first_name: "Erik", email: "mayilyane9@gmail.com", password: "123", password_confirmation: "123")
      expect(@user).to_not be_valid
    end

    it "will not pass if the password has under 6 characters" do
      @user = User.create(first_name: "Erik", last_name: "Mayilyan", email: "mayilyane9@gmail.com", password: "123", password_confirmation: "123")
      if @user.password.length < 6
        expect(@user).to_not be_valid
      end
    end
  end

  describe '.authenticate_with_credentials' do
    # examples for this class method here
    it "will pass if succesfully authenticated" do
      @user = User.create(first_name: "Erik", last_name: "Mayilyan", email: "mayilyane9@gmail.com", password: "123456", password_confirmation: "123456")
      @user.save
      @user = User.authenticate_with_credentials("mayilyane9@gmail.com", "123456")
      expect(@user).to_not be_nil
    end

    it "will not pass if succesfully authenticated" do
      @user = User.create(first_name: "Erik", last_name: "Mayilyan", email: "mayilyane9@gmail.com", password: "123456", password_confirmation: "123456")
      @user.save
      @user = User.authenticate_with_credentials("mayilyan9@gmail.com", "1234")
      expect(@user).to be_nil
    end

    #.squish
    it "will fetch the empty spaces" do
      @user = User.create(first_name: "Erik", last_name: "Mayilyan", email: "mayilyane9@gmail.com", password: "123456", password_confirmation: "123456")
      @user.save
      @user = User.authenticate_with_credentials(" mayilyane9@gmail.com ", "123456")
      expect(@user).to_not be_nil
    end

    it "will be authenticated successfully, regardless of the case" do
      @user = User.create(first_name: "Erik", last_name: "Mayilyan", email: "mayilyane9@gmail.com", password: "123456", password_confirmation: "123456")
      @user.save
      @user = User.authenticate_with_credentials("maYilYaNe9@gmAIl.COM", "123456")
      expect(@user).to_not be_nil
    end
  end

end