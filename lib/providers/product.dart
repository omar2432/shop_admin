import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

//enum Catgory { sports, clothes, food, beverages, other }

class Product with ChangeNotifier {
  final String id;
  final String creatorId;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  String isverified;

  Product({
    @required this.id,
    @required this.creatorId,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    @required this.category,
    @required this.isverified,
  });

  void _setverifiedValue(String newValue) {
    isverified = newValue;
    notifyListeners();
  }

  Future<void> setverifiedStatus(String token, String newValue) async {
    isverified = newValue;
    notifyListeners();
    final url =
        'https://fireeats-434d3.firebaseio.com/products/$id.json?auth=$token';
    try {
      final response = await http.patch(
        url,
        body: json.encode({
          'isverified': isverified,
        }),
      );
      if (response.statusCode >= 400) {
        _setverifiedValue(newValue);
      }
    } catch (error) {
      _setverifiedValue(newValue);
    }
  }
}
