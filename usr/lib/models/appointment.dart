class Appointment {
  final String id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String procedure;
  final DateTime date;

  Appointment({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.procedure,
    required this.date,
  });
}
