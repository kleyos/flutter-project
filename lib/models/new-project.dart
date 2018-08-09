import 'package:add_just/models/area.dart';
import 'package:add_just/models/user.dart';

class NewProject {
  NewProject({
    this.user,
    this.region,
    this.name,
    this.address
  });

  int userId;
  Area region;
  User user;
  String name, address;

  // {"name": "Big Project", "address": ["7 Main Street"], "region": 1, "qs": 1}
  Map<String, dynamic> toJson() {
    return {
      'qs': user.id,
      'region': region.id,
      'name': name,
      'address': [address]
    };
  }
}
