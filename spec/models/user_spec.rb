require 'rails_helper'
require 'pry'

RSpec.describe User, type: :model do
  it "valid with name, email and password" do
    user = User.new(name: "Alex", email: "test@mail.com", password: "12345678")
    expect(user).to be_valid
  end

  context "when user without required attributes" do
    it "invalid user without email" do
      user = User.new(name: "Alex", email: nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "invalid user without password" do
      user = User.new(name: "Alex", email: "test@mail.com", password: nil)
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end
  end

  it "invalid user with not format email" do
    user = User.new(name: "Alex", email: "test.com", password: "12345678")
    user.valid?
    expect(user.errors[:email]).to include("is invalid")
  end

  it "invalid with a duplicate email address" do
    User.create(name: "Alex", email: "test@mail.com", password: "12345678")
    user = User.new(name: "Jane", email: "test@mail.com", password: "9876541213")
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end


end
