import 'package:coffee_admin/stamp.dart';
import 'package:flutter/material.dart';

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
}

Customer _customer1 = Customer("id_0", "Péter", 3, 13, []);

class CustomerBloc extends ChangeNotifier {
  Customer _customer = _customer1;

  Customer get customer => _customer;

  set customer(Customer customer) {
    _customer = customer;
    notifyListeners();
  }

  void add(int number) {
    _customer = _customer.copyWith(
        numberOfStamps: _customer.numberOfStamps + number,
        sumNumberOfStamps: number > 0
            ? _customer.sumNumberOfStamps + number
            : _customer.sumNumberOfStamps);
    notifyListeners();
  }
}
