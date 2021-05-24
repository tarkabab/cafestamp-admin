import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_admin/stamp.dart';

import 'customer.dart';

class FirestoreService {
  final server = FirebaseFirestore.instance;

  Future<String> getName() async {
    final id = "GAoIEEousD3AeXeomZTC";
    final String name = await server
        .doc('coffeeshops/$id')
        .get()
        .then((snapshot) => snapshot.get('name'));
    return name;
  }

  Customer getCustomer(String customerId) => _customer_1;

  List<Stamp> getCoffeeshopStampsHistory() => _coffeeshopStampsHistory;
}

final _customer_1 =
    Customer("customer-001", "Péter", 3, 13, customerStampHistory);

List<Stamp> customerStampHistory = [
  Stamp(DateTime(2021, 1, 3), 1),
  Stamp(DateTime(2021, 1, 4), 1),
  Stamp(DateTime(2021, 1, 5), 1),
  Stamp(DateTime(2021, 1, 10), 1),
  Stamp(DateTime(2021, 1, 11), 1),
  Stamp(DateTime(2021, 1, 12), 1),
  Stamp(DateTime(2021, 1, 17), 1),
  Stamp(DateTime(2021, 1, 18), 1),
  Stamp(DateTime(2021, 1, 19), 1),
  Stamp(DateTime(2021, 1, 24), 1),
  Stamp(DateTime(2021, 1, 25), 1),
  Stamp(DateTime(2021, 1, 26), 1),
  Stamp(DateTime(2021, 1, 31), 1),
];

final Random _random = new Random();
final List<Stamp> _coffeeshopStampsHistory = List<Stamp>.generate(
  30,
  (i) => Stamp(
    DateTime(2021, 1, 15).add(Duration(days: i)),
    20 + _random.nextInt(50),
  ),
);

// final server = FirebaseFirestore.instance
//     .collection('demos/liszt/citizens')
//     .snapshots()
//     .map((documents) => {
//           documents.docChanges.map((change) => {
//                 if (change.type == DocumentChangeType.added)
//                   {
//                     Citizen.def(
//                         change.doc.get('id'),
//                         change.doc.get('name').split(' ')?.elementAt(0),
//                         change.doc.get('name').split(' ')?.elementAt(1),
//                         LatLng(change.doc.get('at').latitude,
//                             change.doc.get('at').longitude))
//                     // add citizen
//                   }
//                 else if (change.type == DocumentChangeType.removed)
//                   {
//                     change.doc['id']
//                     // remove citizen
//                   }
//                 else if (change.type == DocumentChangeType.modified)
//                   {
//                     // update citizen - do nothing
//                     change.doc['id']
//                   }
//               }),
//           documents.docs.map((doc) => Citizen.def(
//                 doc.get('id'),
//                 doc.get('name').split(' ')?.elementAt(0),
//                 doc.get('name').split(' ')?.elementAt(1),
//                 LatLng(doc.get('at').latitude, doc.get('at').longitude),
//               ))
//         });
