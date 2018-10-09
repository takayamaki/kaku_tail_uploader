require 'rails_helper'

describe User, type: :model do
  it "is valid with email, password" do
    user = User.create(email: 'test@example.com', password: 'testPassword', confirmed_at: Time.zone.now)
    expect(user).to be_valid
  end

  it "is invalid without email" do
    user = User.create(password: 'testPassword', confirmed_at: Time.zone.now)
    expect(user).to_not be_valid
  end

  it "is invalid without password" do
    user = User.create(email: 'test@example.com', confirmed_at: Time.zone.now)
    expect(user).to_not be_valid
  end

  it "is valid with email, password, name" do
    user = User.create(email: 'test@example.com', password: 'testPassword', name: 'test name', confirmed_at: Time.zone.now)
    expect(user).to be_valid
  end
end