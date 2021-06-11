import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_admin/model/shop.dart';
import 'package:coffee_admin/model/stamp.dart';

import '../model/customer.dart';

class FirestoreService {
  final _firestore = FirebaseFirestore.instance;

  Future<void> saveShop(Shop shop) async {
    await _firestore.collection("coffeeshop").add(shop.toMap());
  }

  Future<Customer?> getCustomer(String shopId, String customerId) async {
    final path = "/coffeeshop/$shopId/customer/$customerId";
    final snapshot = await _firestore.doc(path).get();
    if (snapshot.exists) {
      final customer = Customer.fromMap(snapshot.data()!, customerId);
      return customer;
    } else {
      // TODO: get name from customer data
      final name = "Peter";
      final customer = Customer(customerId, name, 0, 0, []);
      _firestore.doc(path).set(customer.toMap());
      return customer;
    }
  }

  void updateCustomer(String shopId, Customer customer) async {
    final path = "/coffeeshop/$shopId/customer/${customer.id}";
    await _firestore.doc(path).update({
      'numberOfStamps': customer.numberOfStamps,
      'sumNumberOfStamps': customer.sumNumberOfStamps
    });
  }

  List<Stamp> getCoffeeshopStampsHistory() => _coffeeshopStampsHistory;
}

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
