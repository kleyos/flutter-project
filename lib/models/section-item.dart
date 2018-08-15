class SectionItem {
  SectionItem({
    this.id,
    this.name,
    this.quantity,
    this.measure,
    this.status,
    this.completed
  });

  final num id, quantity;
  final String name, measure, status;
  final bool completed;

  SectionItem.fromApiResponse(Map<String, dynamic> p) :
    id = p['id'],
    name = p['name'],
    quantity = p['quantity'],
    measure = p['measure'],
    status = p['status'],
    completed = p['completed'];
}
