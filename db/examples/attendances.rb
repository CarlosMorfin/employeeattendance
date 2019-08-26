Attendance.create(
  employee:  Employee.find_by(id: 1),
  check_in:  Time.zone.now - 10.hours,
  check_out: Time.zone.now - 1.hours
)

Attendance.create(
  employee:  Employee.find_by(id: 2),
  check_in:  Time.zone.now - 5.hours
)

Attendance.create(
  employee:  Employee.find_by(id: 3),
  check_in:  Time.zone.now - 7.hours
)

Attendance.create(
  employee:  Employee.find_by(id: 4),
  check_in:  Time.zone.now - 1.hours
)

Attendance.create(
  employee:  Employee.find_by(id: 5),
  check_in:  Time.zone.now - 10.hours
)
