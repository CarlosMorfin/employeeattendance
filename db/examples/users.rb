User.create(
  email:                 'administrator@company.com',
  password:              'administrator',
  password_confirmation: 'administrator',
  roles:                 [Role.find_by(code: :administrator)]
)
