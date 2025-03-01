import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ecommerce/helper/local_helper.dart';
import 'package:ecommerce/product/model/product_model.dart';

class CartViewModel extends ChangeNotifier {
  CartViewModel() {
    _loadCartFromStorage(); // Load saved cart when the provider initializes
  }

  List<Product> _cartItems = [];

  List<Product> get cartItem => _cartItems;

  Future<void> saveCart() async {
    String cartData = json.encode(_cartItems.map((e) => e.toJson()).toList());
    SharedPreferencesHelper.setString('cart', cartData);
  }

  Future<void> loadCart() async {
    String? cartData = await SharedPreferencesHelper.getString('cart');
    if (cartData != null) {
      List<dynamic> jsonData = json.decode(cartData);
      _cartItems = jsonData.map((item) => Product.fromJson(item)).toList();
      notifyListeners();
    }
  }

  Future<void> addToCart(Product product) async {
    final index = _cartItems.indexWhere((item) => item.id == product.id);
    if (index >= 0) {
      // If product already exists, increase quantity
      _cartItems[index].quantity++;
    } else {
      // Add new product
      _cartItems.add(product.copyWith(quantity: 1));
    }
    await _saveCartToStorage();
    notifyListeners();
  }

  Future<void> _saveCartToStorage() async {
    final cartJson = jsonEncode(_cartItems.map((e) => e.toJson()).toList());
    await SharedPreferencesHelper.setString('cart', cartJson);
  }

  void removeFromCart(int productId) {
    _cartItems.removeWhere((item) => item.id == productId);
    saveCart();
    notifyListeners();
  }

  void increaseQuantity(Product product) {
    int index = _cartItems.indexWhere((item) => item.id == product.id);
    if (index != -1) {
      _cartItems[index].quantity++;
      saveCart();
      notifyListeners();
    }
  }

  // Decrease Quantity
  void decreaseQuantity(Product product) {
    int index = _cartItems.indexWhere((item) => item.id == product.id);
    if (index != -1 && _cartItems[index].quantity > 1) {
      _cartItems[index].quantity--;
      saveCart();
      notifyListeners();
    }
  }

  // Get Total Price
  double getTotalPrice() {
    return _cartItems.fold(
        0, (total, item) => total + (item.price * item.quantity));
  }

  Future<void> _loadCartFromStorage() async {
    final cartJson = await SharedPreferencesHelper.getString('cart');

    if (cartJson != null) {
      final List<dynamic> decodedList = jsonDecode(cartJson);
      _cartItems = decodedList.map((e) => Product.fromJson(e)).toList();
    }
    notifyListeners();
  }
}
