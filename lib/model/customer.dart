import 'package:coffee_admin/model/shop.dart';
import 'package:coffee_admin/model/stamp.dart';
import 'package:flutter/material.dart';
import 'package:coffee_admin/service/firestore_service.dart';

class Customer {
  final String id;
  final String name;
  final int count;
  final int sum;
  final List<Stamp> visits;

  Customer(this.id, this.name, this.count, this.sum, this.visits);

  Customer copyWith(
          {String? id,
          String? name,
          int? count,
          int? sum,
          List<Stamp>? visits}) =>
      Customer(
        id ?? this.id,
        name ?? this.name,
        count ?? this.count,
        sum ?? this.sum,
        visits ?? this.visits,
      );

  Customer.fromMap(Map<String, dynamic> map, String id)
      : assert(map['name'] != null),
        assert(map['count'] != null),
        assert(map['sum'] != null),
        id = id,
        name = map['name'],
        count = map['count'],
        sum = map['sum'],
        visits = [];
  // TODO: map visits: map['visits'].map((data) => Stamp.fromMap(data)).toList() ?? [];

  Map<String, dynamic> toMap() => {
        "name": name,
        "count": count,
        "sum": sum,
        "visits": [],
      };

  String toString() => "$id $name";
}

class CustomerBloc extends ChangeNotifier {
  Customer? _customer;

  final FirestoreService firestore;

  CustomerBloc(this.firestore);

  Customer? get customer => _customer;

  set customer(Customer? customer) {
    _customer = customer;
    notifyListeners();
  }

  void add(Shop shop, int number) {
    print("customer: $_customer");
    if (_customer == null) return;
    _customer = _customer!.copyWith(
        count: _customer!.count + number,
        sum: number > 0 ? _customer!.sum + number : _customer!.sum);
    firestore.updateCustomer(shop, _customer!);
    notifyListeners();
  }
}
