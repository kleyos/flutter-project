class SectionItem {
  SectionItem({
    this.id,
    this.name,
    this.quantity,
    this.deductedQuantity,
    this.measure,
    this.itemType,
    this.completed,
    this.price,
    this.currency
  });

  final num id, quantity, price, deductedQuantity;
  final String name, measure, itemType, currency;
  final bool completed;

  SectionItem.fromApiResponse(Map<String, dynamic> p) :
    id = p['id'],
    name = p['name'],
    quantity = p['quantity'],
    deductedQuantity = p['deductedQuantity'],
    measure = p['measure'],
    itemType = p['itemType'],
    completed = p['completed'],
    price = p['price'],
    currency = '€';
}
