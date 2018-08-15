//{
//   "id": 1,
//   "orgId": 1,
//   "name": "House Refurb",
//   "address": [
//     "1 Main St",
//     "Kilrush"
//   ],
//   "status": "created",
//   "currentAMO": {
//     "id": 1,
//     "firstName": "Michael",
//     "lastName": "AMO",
//     "role": "amo"
//   },
//   "currentQS": {
//     "id": 5,
//     "firstName": "Mary",
//     "lastName": "QS",
//     "role": "qs"
//   },
//   "currentCTR": null,
//   "sections": [
//     {
//       "name": "Kitchen",
//       "items": [
//         {
//           "id": 1,
//           "name": "20mm X 100mm Skirting",
//           "quantity": 10,
//           "measure": "linm",
//           "status": "draft",
//           "completed": false
//         },
//         ...
//       ]
//     },
//     {
//       "name": "Dining Room",
//       "items": []
//     }
//   ],
//   "additions": [],
//   "deductions": []
// }

import 'package:add_just/models/inline-project-section.dart';
import 'package:add_just/models/user.dart';

class Project {
  Project({
    this.id,
    this.orgId,
    this.name,
    this.status,
    this.location,
    this.currentAMO,
    this.currentQS,
    this.currentCTR,
  });

  final num id, orgId;
  String name, status;
  List<String> location;
  List<InlineProjectSection> sections;
  User currentAMO, currentQS, currentCTR;

  Project.fromApiResponse(Map<String, dynamic> p) :
    id = p['id'],
    orgId = p['org_id'],
    name = p['name'],
    location = p['location'],
    currentAMO = p['currentAMO'] != null ? User.fromApiResponse(p['currentAMO']) : null,
    currentQS = p['currentQS'] != null ? User.fromApiResponse(p['currentQS']) : null,
    currentCTR = p['currentCTR'] != null ? User.fromApiResponse(p['currentCTR']) : null,
    sections = p['sections'] != null
      ? List.from(p['sections']).map((e) => InlineProjectSection.fromApiResponse(e)).toList()
      : [];
}
