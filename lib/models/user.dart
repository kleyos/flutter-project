class User {
  User({
    this.id,
    this.firstName,
    this.lastName,
    this.role,
    this.status
  });

  final int id;
  final String firstName, lastName, role, status;

  User.fromApiResponse(Map<String, dynamic> a) :
    id = a['id'],
    firstName = a['firstName'],
    lastName = a['lastName'],
    role = a['role'],
    status = a['status'];

  String get displayName => [firstName, lastName].join(' ');
}
