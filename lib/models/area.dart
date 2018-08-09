import 'package:add_just/services/api/base.dart';

class Area {
  Area({
    this.id,
    this.name
  });

  final int id;
  final String name;

  Area.fromApiResponse(Map<String, dynamic> a) :
    id = a['id'],
    name = a['name'];
}
