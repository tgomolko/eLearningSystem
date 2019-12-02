require 'rails_helper'
require 'pry'

RSpec.describe User, type: :model do
  it "valid with name, email and password" do
    user = User.new(name: "Alex", email: "test@mail.com", password: "12345678")
    expect(user).to be_valid
  end

  context "when user without required attributes" do
    it "is invalid without email" do
      user = User.new(name: "Alex", email: nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "is invalid without password" do
      user = User.new(name: "Alex", email: "test@mail.com", password: nil)
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end
  end

  it "is invalid with not format email" do
    user = User.new(name: "Alex", email: "test.com", password: "12345678")
    user.valid?
    expect(user.errors[:email]).to include("is invalid")
  end

  it "is invalid with too short password" do
    user = User.new(name: "Alex", email: "test.com", password: "sd12")
    user.valid?
    expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
  end

  it "has a unique email address" do
    create(:user)
    user = User.new(name: "Jane", email: "joe@elearning.com", password: "9876541213")
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end

  describe "follow//unfollow" do
    it "add course to following" do
      course = create(:course)
      user = create(:user, email: "qwe@mail.com")
      user.follow(course)
      expect(user.following).to include(course)
    end

    it "remove course from following" do
      course = create(:course)
      user = create(:user, email: "qwe@mail.com")
      user.follow(course)
      user.unfollow(course)
      expect(user.following).to eq([])
    end

    it "return true if following course" do
      course = create(:course)
      user = create(:user, email: "qwe@mail.com")
      user.follow(course)
      expect(user.following?(course)).to be_truthy
    end
  end

  it "return true if user role admin" do
    user = create(:user)
    user.update(role: "admin")
    expect(user.admin?).to be_truthy
  end

  it "return true if user role org_admin" do
    user = create(:user)
    user.update(role: "org_admin")
    expect(user.org_admin?).to be_truthy
  end
end
