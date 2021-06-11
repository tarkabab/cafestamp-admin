import 'package:coffee_admin/service/firestore_service.dart';
import 'package:flutter/material.dart';

class Shop {
  final String id;
  final String name;

  Shop(this.id, this.name);

  Shop.fromMap(String id, Map<String, dynamic> map)
      : assert(map['name'] != null),
        id = id,
        name = map['name'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class ShopBloc extends ChangeNotifier {
  Shop? _shop;

  final FirestoreService firestore;

  ShopBloc(this.firestore);

  Shop? get shop => _shop;

  set shop(Shop? shop) {
    _shop = shop;
    notifyListeners();
  }
}
