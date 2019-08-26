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

  it 'delegate the employee_code method to the employee model' do
    expect(attendance.employee_code).to eq attendance.employee.code
  end

  it 'delegate the employee_full_name method to the employee model' do
    expect(attendance.employee_full_name).to eq attendance.employee.full_name
  end

  describe '#current_attendances' do

    before(:each) do
      @attendance_1 = FactoryBot.create(:attendance)
      @attendance_2 = FactoryBot.create(:attendance, check_out: Time.zone.now)
      @attendance_3 = FactoryBot.create(:attendance)
    end

    it 'return attendances without check_out sorted by check_in in ' \
       'descending order' do
      expect(Attendance.current_attendances).to eq [@attendance_3, @attendance_1]
    end

  end

end
