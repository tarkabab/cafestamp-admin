import 'package:coffee_admin/model/stamp.dart';
import 'package:flutter/material.dart';
import 'package:coffee_admin/service/firestore_service.dart';

class Customer {
  final String id;
  final String displayName;
  final int numberOfStamps;
  final int sumNumberOfStamps;
  final List<Stamp> visits;

  Customer(this.id, this.displayName, this.numberOfStamps,
      this.sumNumberOfStamps, this.visits);

  Customer copyWith(
          {String? id,
          String? displayName,
          int? numberOfStamps,
          int? sumNumberOfStamps,
          List<Stamp>? visits}) =>
      Customer(
        id ?? this.id,
        displayName ?? this.displayName,
        numberOfStamps ?? this.numberOfStamps,
        sumNumberOfStamps ?? this.sumNumberOfStamps,
        visits ?? this.visits,
      );

  Customer.fromMap(Map<String, dynamic> map, String id)
      : assert(map['displayName'] != null),
        assert(map['numberOfStamps'] != null),
        assert(map['sumNumberOfStamps'] != null),
        id = id,
        displayName = map['displayName'],
        numberOfStamps = map['numberOfStamps'],
        sumNumberOfStamps = map['sumNumberOfStamps'],
        visits = [];
  // TODO: map visits: map['visits'].map((data) => Stamp.fromMap(data)).toList() ?? [];

  Map<String, dynamic> toMap() => {
        "displayName": displayName,
        "numberOfStamps": numberOfStamps,
        "sumNumberOfStamps": sumNumberOfStamps,
        "visits": [],
      };
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

  void add(String shopId, int number) {
    print("customer: $_customer");
    if (_customer == null) return;
    _customer = _customer!.copyWith(
        numberOfStamps: _customer!.numberOfStamps + number,
        sumNumberOfStamps: number > 0
            ? _customer!.sumNumberOfStamps + number
            : _customer!.sumNumberOfStamps);
    firestore.updateCustomer(shopId, _customer!);
    notifyListeners();
  }
}
