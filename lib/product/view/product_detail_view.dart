import 'package:flutter/material.dart';
import 'package:ecommerce/cart/model/cart_viewmodel.dart';
import 'package:ecommerce/product/model/product_model.dart';
import 'package:ecommerce/helper/sized_box_ext.dart';
import 'package:ecommerce/utils/app_colors.dart';
import 'package:provider/provider.dart';

class ProductDetailView extends StatefulWidget {
  final Product selectedProduct;
  const ProductDetailView({super.key, required this.selectedProduct});

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  @override
  Widget build(BuildContext context) {
    final data = widget.selectedProduct;
    final size = MediaQuery.sizeOf(context);
    final cartViewModel = Provider.of<CartViewModel>(context);

    bool isInCart = cartViewModel.cartItem.any((item) => item.id == data.id);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Product Detail",
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
      body: ListView(
        children: [
          Image.network(
            data.image,
            height: size.height * 0.50,
            width: size.width,
          ),
          10.kH,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.kH,
              Text(
                data.title,
                style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff3D3D3D),
                    fontWeight: FontWeight.bold),
              ),
              10.kH,
              RichText(
                  text: TextSpan(
                      text: "Category:  ",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                      children: [
                    TextSpan(
                        text: data.category,
                        style: TextStyle(
                            fontSize: 12,
                            color: AppColors.mainColor,
                            fontWeight: FontWeight.w400))
                  ])),
              10.kH,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                      text: TextSpan(
                    text: "\$ ${data.price.toString()}",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  )),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber),
                      Text("${data.rating.rate} (${data.rating.count} reviews)",
                          style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                ],
              ),
              10.kH,
              Text(
                "Description",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              5.kH,
              Text(
                data.description,
                style: TextStyle(fontSize: 14, color: Color(0xff3D3D3D)),
              ),
              40.kH,
            ],
          ).myPadding(val: size.width > 840 ? 32 : 16)
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: GestureDetector(
          onTap: isInCart
              ? null
              : () {
                  cartViewModel.addToCart(data);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Product added to cart")),
                  );
                },
          child: BottomAppBar(
            color: AppColors.mainColor,
            child: Center(
                child: Text(
              isInCart ? "Already in Cart" : "Add to Cart",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )),
          ),
        ),
      ),
    );
  }
}
