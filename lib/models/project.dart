import 'package:add_just/services/api/base.dart';

class Project {
  Project({
    this.id,
    this.orgId,
    this.name,
    this.location
  });

  final num id, orgId;
  String name;
  List<String> location;

  Project.fromApiResponse(ApiResponse resp) :
    id = resp['id'],
    orgId = resp['org_id'],
    name = resp['name'],
    location = resp['location'];
}
