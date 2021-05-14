import 'package:flutter/material.dart';

final customers = [customer_1];

final Widget customersPage = customerCard(customers[0]);

class Customer {
  final String id;
  final int numberOfStamps;
  final int sumNumberOfStamps;
  final List<DateTime> visits;

  Customer(this.id, this.numberOfStamps, this.sumNumberOfStamps, this.visits);
}

final customer_1 = Customer("customer 1", 3, 13, [
  DateTime(2021, 1, 3),
  DateTime(2021, 1, 4),
  DateTime(2021, 1, 5),
  DateTime(2021, 1, 10),
  DateTime(2021, 1, 11),
  DateTime(2021, 1, 12),
  DateTime(2021, 1, 17),
  DateTime(2021, 1, 18),
  DateTime(2021, 1, 19),
  DateTime(2021, 1, 24),
  DateTime(2021, 1, 25),
  DateTime(2021, 1, 26),
  DateTime(2021, 1, 31),
]);

ListView customerCard(Customer customer) {
  return ListView(
      children: [
            ListTile(title: Text("Vendég: ${customer.id}"), dense: true),
            ListTile(
                title: Text("Aktuális bélyegek: ${customer.numberOfStamps}"),
                dense: true),
            ListTile(
                title: Text("Összes bélyeg: ${customer.sumNumberOfStamps}"),
                dense: true),
          ] +
          customer.visits
              .map(
                  (date) => ListTile(title: Text(date.toString()), dense: true))
              .toList());
}
