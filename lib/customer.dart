import 'package:coffee_admin/stamp.dart';

class Customer {
  final String id;
  final String displayName;
  final int numberOfStamps;
  final int sumNumberOfStamps;
  final List<Stamp> visits;

  Customer(this.id, this.displayName, this.numberOfStamps,
      this.sumNumberOfStamps, this.visits);
}
