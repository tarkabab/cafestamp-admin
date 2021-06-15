import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_admin/model/shop.dart';
import 'package:coffee_admin/model/stamp.dart';

import '../model/customer.dart';

class FirestoreService {
  final _firestore = FirebaseFirestore.instance;

  void saveShop(Shop shop) {
    _firestore.doc("coffeeshops/${shop.id}").set(shop.toMap());
  }

  Future<Customer?> getCustomer(String shopId, String customerId) async {
    final path = "/coffeeshops/$shopId/customers/$customerId";
    final snapshot = await _firestore.doc(path).get();
    if (snapshot.exists) {
      final customer = Customer.fromMap(snapshot.data()!, customerId);
      return customer;
    } else {
      final customerPath = "/customers/$customerId";
      final customerSnapshot = await _firestore.doc(customerPath).get();
      if (customerSnapshot.exists) {
        final customer =
            Customer(customerId, customerSnapshot['name'], 0, 0, []);
        _firestore.doc(path).set(customer.toMap());
        return customer;
      } else {
        return null;
      }
    }
  }

  void updateCustomer(Shop shop, Customer customer) {
    final customerByShopPath =
        "/coffeeshops/${shop.id}/customers/${customer.id}";
    _firestore.doc(customerByShopPath).update(
        {'numberOfStamps': customer.count, 'sumNumberOfStamps': customer.sum});
    final shopByCustomerPath = "/customers/${customer.id}/shops/${shop.id}";
    // id, name, count
    _firestore.doc(shopByCustomerPath).set({
      'id': shop.id,
      'name': shop.name,
      'count': customer.count,
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
