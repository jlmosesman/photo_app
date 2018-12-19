require 'rails_helper'

RSpec.describe User, type: :model do
  it "validates user data" do
    expect(User.new.valid?).to eq(false)

    user = create(:user)

    expect(user.valid?).to eq(true)
  end

  it "validates email" do
    user = User.new(
      first_name: 'Bob',
      last_name: 'Smith',
      email: 'invalid@email,com',
      password: 'password',
      password_confirmation: 'password'
    )
    user.validate

    expect(user.errors.first).to eq([:email, "is invalid"])
  end

  it "should not allow duplicate user emails" do
    user1 = User.create(
      first_name: 'Bob',
      last_name: 'Smith',
      email: 'bob@email.com',
      password: 'password',
      password_confirmation: 'password'
    )

    user2 = User.create(
      first_name: 'Bob',
      last_name: 'Anderson',
      email: 'Bob@email.com', # same email
      password: 'password',
      password_confirmation: 'password'
    )

    expect(user2.valid?).to eq(false)
  end

  it "can't have blank password" do
    user = User.new(
      first_name: 'Bob',
      last_name: 'Smith',
      email: 'user@email.com',
      password: ' ',
      password_confirmation: ' '
    )
    user.validate

    expect(user.errors.first).to eq([:password, "can't be blank"])
  end

  it "can't have blank email" do
    user = User.new(
      first_name: 'Bob',
      last_name: 'Smith',
      email: ' ',
      password: 'password',
      password_confirmation: 'password'
    )
    user.validate

    expect(user.errors.first).to eq([:email, "can't be blank"])
  end

  it "requires 6 minimum length of password" do
    user = User.new(
      first_name: 'Bob',
      last_name: 'Smith',
      email: 'user@email.com',
      password: 'pas',
      password_confirmation: 'pas'
    )
    user.validate

    expect(user.errors.first).to eq([:password, "is too short (minimum is 6 characters)"])
  end
end
