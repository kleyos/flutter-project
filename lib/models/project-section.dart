class ProjectSection {
  ProjectSection({
    this.id,
    this.name,
    this.numItems
  });

  final num id, numItems;
  final String name;

  ProjectSection.fromApiResponse(Map<String, dynamic> p) :
    id = p['id'],
    name = p['name'],
    numItems = p['numItems'];
}
