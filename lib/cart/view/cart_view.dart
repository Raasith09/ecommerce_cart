import 'package:flutter/material.dart';
import 'package:ecommerce/cart/model/cart_viewmodel.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartViewModel = Provider.of<CartViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Cart",
          style: TextStyle(
              fontSize: 24,
              color: Color(0xff3D3D3D),
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.chevron_left,
              size: 35,
            )),
      ),
      body: cartViewModel.cartItem.isEmpty
          ? const Center(
              child: Text(
              "Cart is Empty",
              style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff3D3D3D),
                  fontWeight: FontWeight.w500),
            ))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartViewModel.cartItem.length,
                    itemBuilder: (context, index) {
                      final product = cartViewModel.cartItem[index];
                      return ListTile(
                        leading: Image.network(product.image, width: 50),
                        title: Text(product.title),
                        subtitle:
                            Text("\$${product.price} x ${product.quantity}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () =>
                                    cartViewModel.decreaseQuantity(product),
                                icon: const Icon(Icons.remove)),
                            IconButton(
                                onPressed: () =>
                                    cartViewModel.increaseQuantity(product),
                                icon: const Icon(Icons.add)),
                            IconButton(
                                onPressed: () =>
                                    cartViewModel.removeFromCart(product.id),
                                icon: const Icon(Icons.delete,
                                    color: Colors.red)),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Text(
                    "Total: \$${cartViewModel.getTotalPrice().toStringAsFixed(2)}",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
    );
  }
}
