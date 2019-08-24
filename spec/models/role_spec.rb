require 'rails_helper'

describe Role do

  subject(:role) { FactoryBot.build(:role) }

  it 'is valid with a code' do
    expect(role).to be_valid
  end

  it 'is not valid without a code' do
    role.code = nil

    expect(role).not_to be_valid
  end

  it 'is not valid if the code has more than 32 characters' do
    role.code = 'a' * 33

    expect(role).not_to be_valid
  end

  it 'is not valid if the code already exists' do
    FactoryBot.create(:role, code: role.code)

    expect(role).not_to be_valid
  end

end
