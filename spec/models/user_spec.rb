# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it "validates presence of name" do
      user = User.new(status: 'active', email: 'user@example.com', number: 123)
      expect(user).to_not be_valid
      expect(user.errors[:name]).to include("can't be blank")
    end

    it "validates inclusion of status" do
      user = User.new(name: 'John Doe', status: 'invalid', email: 'user@example.com', number: 123)
      expect(user).to_not be_valid
      expect(user.errors[:status]).to include("is not included in the list")
    end

    it "validates presence and uniqueness of email" do
      User.create(name: 'John Doe', status: 'active', email: 'user@example.com', number: 123)
      user = User.new(name: 'Jane Doe', status: 'active', email: 'user@example.com', number: 456)
      expect(user).to_not be_valid
      expect(user.errors[:email]).to include("has already been taken")
    end

    it "validates format of email" do
      user = User.new(name: 'John Doe', status: 'active', email: 'invalid_email', number: 123)
      expect(user).to_not be_valid
      expect(user.errors[:email]).to include("is invalid")
    end
  end
end
