class BoqItem {
  BoqItem({
    this.category,
    this.subCategory,
    this.name,
    this.measure
  });

  final String name, category, subCategory, measure;

  BoqItem.fromApiResponse(Map<String, dynamic> p) :
    category = p['category'],
    subCategory = p['subCategory'],
    name = p['name'],
    measure = p['measure'];
}
