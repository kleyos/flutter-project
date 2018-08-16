import 'package:add_just/models/boq-item.dart';

class BoqItemsContainer {
  BoqItemsContainer({
    this.items
  });

  final List<BoqItem> items;

  List<String> get categories => items.map((i) => i.category).toSet().toList();
}
