import 'package:add_just/models/section-item.dart';

class ProjectSection {
  ProjectSection({
    this.id,
    this.name,
    this.scopeItems
  });

  final int id;
  final String name;
  final List<SectionItem> scopeItems;

  ProjectSection.fromApiResponse(Map<String, dynamic> p) :
    id = p['id'],
    name = p['name'],
    scopeItems = p['scopeItems'] != null
      ? List.from(p['scopeItems']).map((e) => SectionItem.fromApiResponse(e)).toList()
      : [];

  int get itemsCount => scopeItems.length;
  bool get isEmpty => itemsCount == 0;
}
