module EmployeesHelper

  def hp_employee_gender_options_for_select(selected)
    genders_collection = Employee::GENDER_OPTIONS.map do |gender|
      [hp_human_code_name_for(:employee, gender), gender]
    end

    options_for_select(genders_collection, selected)
  end

end
