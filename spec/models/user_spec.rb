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

  context "returns role" do
    it "when unauthorized" do
      user = User.create(email: 'test@example.com', password: 'testPassword', name: 'test name', confirmed_at: Time.zone.now, role: 0)
      expect(user.role).to eq "unauthorized"
      expect(user.authorized?).to eq false
      expect(user.staff?).to eq false
    end

    it "when creator" do
      user = User.create(email: 'test@example.com', password: 'testPassword', name: 'test name', confirmed_at: Time.zone.now, role: 1)
      expect(user.role).to eq "creator"
      expect(user.authorized?).to eq true
      expect(user.staff?).to eq false
    end

    it "when staff" do
      user = User.create(email: 'test@example.com', password: 'testPassword', name: 'test name', confirmed_at: Time.zone.now, role: 2)
      expect(user.role).to eq "staff"
      expect(user.authorized?).to eq true
      expect(user.staff?).to eq true
    end

    it "when organizer" do
      user = User.create(email: 'test@example.com', password: 'testPassword', name: 'test name', confirmed_at: Time.zone.now, role: 3)
      expect(user.role).to eq "organizer"
      expect(user.authorized?).to eq true
      expect(user.staff?).to eq true
    end

    it "when admin" do
      user = User.create(email: 'test@example.com', password: 'testPassword', name: 'test name', confirmed_at: Time.zone.now, role: 4)
      expect(user.role).to eq "admin"
      expect(user.authorized?).to eq true
      expect(user.staff?).to eq true
    end

  end
end