import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/product_model.dart';

class LocalProductDataSource {
  Future<List<ProductModel>> getProducts() async {
    final jsonString = await rootBundle.loadString('assets/products.json');
    final decoded = jsonDecode(jsonString) as List<dynamic>;
    return decoded
        .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
