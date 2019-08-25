employee_data = [
  ['Juan',    'Sanchez Gutierres', 'M', 'juan_sanchez'],
  ['Erika',   'Díaz Gonzalez',     'F', 'erika_diaz'],
  ['Eduardo', 'Perez López',       'M', 'eduardo_perez'],
  ['Carlos',  'Avila Hernandez',   'M', 'calos_avila'],
  ['Elias',   'Torres Ramos',      'M', 'elias_torres'],
  ['Claudia', 'Pardo Morales',     'F', 'claudia_pardo'],
  ['Brenda',  'Lopez Garcia',      'F', 'brenda_lopez']
]
employee_data.each_with_index do |employee, i|
  name, last_names, gender, email_prefix = *employee

  Employee.create(
    code:       'COMP' + "%03d" % (i + 1),
    name:       name,
    last_names: last_names,
    gender:     gender,
    email:      email_prefix + '@company.com',
    phone:      (rand() * 9999999999).to_i.to_s
  )
end
