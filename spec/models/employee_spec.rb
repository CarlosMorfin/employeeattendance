require 'rails_helper'

describe Employee do

  subject(:employee) { FactoryBot.build(:employee) }

  it 'is valid with a code, name, last_names, gender, email and a phone' do
    expect(employee).to be_valid
  end

  it 'is not valid without a code' do
    employee.code = nil

    expect(employee).not_to be_valid
  end

  it 'is not valid if code has more than 32 characters' do
    employee.code = 'a' * 33

    expect(employee).not_to be_valid
  end

  it 'is not valid if the code already exists' do
    FactoryBot.create(:employee, code: employee.code)

    expect(employee).not_to be_valid
  end

  it 'is not valid without a name' do
    employee.name = nil

    expect(employee).not_to be_valid
  end

  it 'is not valid if name has more than 64 characters' do
    employee.name = 'a' * 65

    expect(employee).not_to be_valid
  end

  it 'is not valid valid without last names' do
    employee.last_names = nil

    expect(employee).not_to be_valid
  end

  it 'is not valid if last names has more than 64 characters' do
    employee.last_names = 'a' * 65

    expect(employee).not_to be_valid
  end

  it 'is not valid valid without email' do
    employee.email = nil

    expect(employee).not_to be_valid
  end

  it 'is not valid if email has more than 128 characters' do
    employee.email = "#{'a' * 119}@example.com"

    expect(employee).not_to be_valid
  end

  it 'is not valid if the email already exists' do
    FactoryBot.create(:employee, email: employee.email)

    expect(employee).not_to be_valid
  end

  it 'is not valid if phone number has more than 32 characters' do
    employee.phone = '4' * 33

    expect(employee).not_to be_valid
  end

  it 'is not valid without gender' do
    employee.gender = nil

    expect(employee).not_to be_valid
  end

  it 'is not valid if gender has more than 1 character' do
    employee.gender = 'ff'

    expect(employee).not_to be_valid
  end

  it 'the full_name method of employee returns the name plus the last names' do
    employee.name       = 'John'
    employee.last_names = 'Doe F'

    expect(employee.full_name).to eq('John Doe F')
  end

end
