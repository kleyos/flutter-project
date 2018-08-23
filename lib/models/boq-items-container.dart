class BoqItem {
  BoqItem({
    this.id,
    this.name,
    this.measure
  });

  final int id;
  final String name, measure;
}

class BoqItemsSubcategory {
  BoqItemsSubcategory({
    this.name,
    this.items
  });

  final String name;
  final List<BoqItem> items;

  BoqItemsSubcategory.fromApiResponse(List<Map<String, dynamic>> data):
    name = data[0]['subCategory'],
    items = data.map((i) => new BoqItem(id: i['id'], name: i['name'], measure: i['measure'])).toList();
}

class BoqItemsCategory {
  BoqItemsCategory({
    this.name,
    this.subCategories
  });

  final String name;
  final List<BoqItemsSubcategory> subCategories;

  BoqItemsCategory.fromApiResponse(List<Map<String, dynamic>> data):
    name = data[0]['category'],
    subCategories = data.map((i) => i['subCategory']).toSet().toList().map((name) =>
      BoqItemsSubcategory.fromApiResponse(data.where((n) => n['subCategory'] == name).toList())
    ).toList();
}

//[
//  {
//    "category": "Board Finishes",
//    "subCategory": "Woodwork",
//    "name": "Floors on concrete surface",
//    "measure": "sqm"
//  },
//  ...
//]

class BoqItemsContainer {
  BoqItemsContainer({
    this.categories
  });

  final List<BoqItemsCategory> categories;

  BoqItemsCategory getCatByName(String name) {
    return categories.singleWhere((cat) => cat.name == name, orElse: () => null);
  }

  BoqItemsContainer.fromApiResponse(List<Map<String, dynamic>> data):
    categories = data.map((i) => i['category']).toSet().toList().map((name) =>
      BoqItemsCategory.fromApiResponse(data.where((n) => n['category'] == name).toList())
    ).toList();
}
