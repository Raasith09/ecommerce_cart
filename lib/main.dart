import 'package:flutter/material.dart';
import 'package:ecommerce/cart/model/cart_viewmodel.dart';
import 'package:ecommerce/product/view/product_list.dart';
import 'package:provider/provider.dart';

import 'product/viewmodel/product_viewmodel.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => ProductViewModel()..fetchProducts(),
        child: MyApp(),
      ),
      ChangeNotifierProvider(create: (_) => CartViewModel()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product App',
      home: ProductList(),
    );
  }
}
