require 'rails_helper'

describe User do

  subject(:user) { FactoryBot.build(:user) }

  it 'is valid with an email and a password' do
    expect(user).to be_valid
  end

  it 'is not valid without email' do
    user.email = nil

    expect(user).not_to be_valid
  end

  it 'is not valid if the email already exists' do
    FactoryBot.create(:user, email: user.email)

    expect(user).not_to be_valid
  end

  it 'is not valid without a password' do
    user.password              = nil
    user.password_confirmation = nil

    expect(user).not_to be_valid
  end

  it 'is not valid if the password has less than 6 characters' do
    user.password              = 'a'
    user.password_confirmation = 'a'

    expect(user).not_to be_valid
  end

  it 'is not valid if the password has more than 16 characters' do
    user.password              = 'a' * 17
    user.password_confirmation = 'a' * 17

    expect(user).not_to be_valid
  end

  it 'is not valid without a password confirmation' do
    user.password              = 'a' * 12
    user.password_confirmation = nil

    expect(user).not_to be_valid
  end

  it 'is not valid if the password confirmation doesn\'t match' do
    user.password              = 'a' * 12
    user.password_confirmation = 'b' * 12

    expect(user).not_to be_valid
  end

end
