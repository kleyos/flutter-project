// User roles
// 'superadmin',
// 'org_admin',
// 'amo',
// 'ctr',
// 'qs',
// 'architect',
// 'finance'

import 'package:add_just/models/roleable.dart';

class User extends Roleable {
  User({
    this.id,
    this.firstName,
    this.lastName,
    this.role,
    this.status
  });

  final int id;
  final String firstName, role, lastName, status;

  User.fromApiResponse(Map<String, dynamic> a) :
    id = a['id'],
    firstName = a['firstName'],
    lastName = a['lastName'],
    role = a['role'],
    status = a['status'];

  String get displayName => [firstName, lastName].join(' ');
}
