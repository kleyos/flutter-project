class SectionItem {
  SectionItem({
    this.id,
    this.name,
    this.quantity,
    this.measure,
    this.itemType,
    this.completed,
    this.price,
    this.currency
  });

  final num id, quantity, price;
  final String name, measure, itemType, currency;
  final bool completed;

  SectionItem.fromApiResponse(Map<String, dynamic> p) :
    id = p['id'],
    name = p['name'],
    quantity = p['quantity'],
    measure = p['measure'],
    itemType = p['itemType'],
    completed = p['completed'],
    price = p['price'],
    currency = '€';
}
