import 'package:add_just/services/api/base.dart';

class User {
  User({
    this.id,
    this.email,
    this.accessToken,
    this.firstName,
    this.lastName,
    this.role,
    this.status,
    this.orgId
  });

  final num id, orgId;
  final String email, accessToken;
  String firstName, lastName, role, status;


  bool get isAuthenticated => accessToken != null && accessToken.isNotEmpty;

//  {
//  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxMCwiZW1haWwiOiJ2aWFjaGVzbGF2LnBldHJlbmtvQGxpdHNsaW5rLmNvbSIsInJvbGUiOiJhbW8iLCJoYXNoIjoiZGFjNTgzNjAtYTIwMi00NTA0LWE3NDctMDczNWQxMGZkODlhIiwib3JnX2lkIjoxLCJhdWQiOiJwb3N0Z3JhcGhpbGUiLCJpYXQiOjE1MzMyMjA2MTUsImV4cCI6MTU5NjMzNTgxNX0.UB5ptUrC5cFCCbJWAoQJkzhGuxZFhzjEwc2iSTNo1vU",
//    "user": {
//      "id": 10,
//      "org_id": 1,
//      "email": "viacheslav.petrenko@litslink.com",
//      "first_name": "Viacheslav",
//      "last_name": "Petrenko",
//      "role": "amo",
//      "status": "activated"
//    }
//  }

    User.fromApiResponse(ApiResponse resp) :
    id = resp['user']['id'],
    orgId = resp['user']['org_id'],
    email = resp['user']['email'],
    firstName = resp['user']['first_name'],
    lastName = resp['user']['last_name'],
    role = resp['user']['role'],
    status = resp['user']['status'],
    accessToken = resp['token'];
}
