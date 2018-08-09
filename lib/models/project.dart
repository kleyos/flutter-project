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

  Project.fromApiResponse(Map<String, dynamic> p) :
    id = p['id'],
    orgId = p['org_id'],
    name = p['name'],
    location = p['location'];
}
