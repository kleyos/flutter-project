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

import 'package:add_just/models/project-section.dart';
import 'package:add_just/models/section-item.dart';
import 'package:add_just/models/user.dart';

// Project statuses:
// created,
// work_commenced,
// marked_completed,
// completion_cert_issued,
// payment_claim_submitted,
// payment_recommendation_issued,
// payment_certification_issued,
// invoice_received,
// paid

class Project {
  Project({
    this.id,
    this.orgId,
    this.name,
    this.status,
    this.address,
    this.unreadMessages,
    this.currentAMO,
    this.currentQS,
    this.currentCTR,
    this.sections,
    this.additions
  });
  
  final num id, orgId, unreadMessages;
  String name, status;
  List<String> address;
  List<ProjectSection> sections;
  ProjectSection additions;
  User currentAMO, currentQS, currentCTR;

  Project.fromApiResponse(Map<String, dynamic> p) :
    id = p['id'],
    orgId = p['orgId'],
    name = p['name'],
    status = p['status'],
    unreadMessages = p['unreadMessages'],
    address = List.from(p['address']).map((i) => i as String).toList(),
    currentAMO = p['currentAMO'] != null ? User.fromApiResponse(p['currentAMO']) : null,
    currentQS = p['currentQS'] != null ? User.fromApiResponse(p['currentQS']) : null,
    currentCTR = p['currentCTR'] != null ? User.fromApiResponse(p['currentCTR']) : null,
    sections = p['sections'] != null
      ? List.from(p['sections']).map((e) => ProjectSection.fromApiResponse(e)).toList()
      : [],
    additions = p['additions'] != null
      ? new ProjectSection(id: 0, name: 'Additions', scopeItems: List.from(p['additions']).map((e) => SectionItem.fromApiResponse(e)).toList())
      : null;

  bool get isNew => status == 'created';
  bool get isCompleted => status == 'paid';
  bool get isMarkedCompleted => status == 'marked_completed';

  ProjectSection sectionByName(String name) {
    return sections.firstWhere((s) => s.name == name);
  }

  ProjectSection sectionById(int id) {
    return sections.firstWhere((s) => s.id == id);
  }
}
