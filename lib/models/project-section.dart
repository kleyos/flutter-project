import 'package:add_just/models/section-item.dart';

class ProjectSection {
  ProjectSection({
    this.name,
    this.scopeItems
  });

  final String name;
  final List<SectionItem> scopeItems;

  ProjectSection.fromApiResponse(Map<String, dynamic> p) :
    name = p['name'],
      scopeItems = p['scopeItems'] != null
      ? List.from(p['scopeItems']).map((e) => SectionItem.fromApiResponse(e)).toList()
      : [];

  int get itemsCount => scopeItems.length;
  bool get isEmpty => itemsCount == 0;
}
