import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce/product/model/product_model.dart';
import 'package:ecommerce/utils/app_strings.dart';

enum ProductState { loading, success, empty, error, connectionFailed }

class ProductViewModel extends ChangeNotifier {
  List<Product> products = [];
  ProductState _state = ProductState.loading;

  ProductState get state => _state;

  Future<void> fetchProducts() async {
    _state = ProductState.loading;
    notifyListeners();

    try {
      final response = await http
          .get(Uri.parse(AppStrings.appUrl))
          .timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);

        if (jsonData.isEmpty) {
          _state = ProductState.empty;
        } else {
          products = jsonData.map((e) => Product.fromJson(e)).toList();
          _state = ProductState.success;
        }
      } else {
        _state = ProductState.error;
      }
    } catch (e) {
      if (e is http.ClientException ||
          e.toString().contains('TimeoutException')) {
        _state = ProductState.connectionFailed;
      } else {
        _state = ProductState.error;
      }
    }

    notifyListeners();
  }
}
