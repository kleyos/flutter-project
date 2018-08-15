import 'package:add_just/models/section-item.dart';

class InlineProjectSection {
  InlineProjectSection({
    this.name,
    this.items
  });

  final String name;
  final List<SectionItem> items;

  InlineProjectSection.fromApiResponse(Map<String, dynamic> p) :
    name = p['name'],
    items = p['items'] != null
      ? List.from(p['items']).map((e) => SectionItem.fromApiResponse(e)).toList()
      : [];
}
