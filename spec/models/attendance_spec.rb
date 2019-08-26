require 'rails_helper'

describe Attendance do

  subject(:attendance) { FactoryBot.build(:attendance) }

  it 'is valid with a employee_id and a check_in' do
    expect(attendance).to be_valid
  end

  it 'is not valid without a employee_id' do
    attendance.employee_id = nil

    expect(attendance).not_to be_valid
  end

  it 'is not valid without a check_in' do
    attendance.check_in = nil

    expect(attendance).not_to be_valid
  end

end
