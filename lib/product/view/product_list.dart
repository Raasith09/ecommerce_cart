import 'package:flutter/material.dart';
import 'package:ecommerce/cart/view/cart_view.dart';
import 'package:ecommerce/product/model/product_model.dart';
import 'package:ecommerce/product/viewmodel/product_viewmodel.dart';
import 'package:ecommerce/utils/app_colors.dart';
import 'package:ecommerce/widget/custom_failed_network.dart';
import 'package:ecommerce/widget/custom_noproducts.dart';
import 'package:ecommerce/widget/custom_server_error.dart';
import 'package:provider/provider.dart';

import 'product_detail_view.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    final floatButton = FloatingActionButton(
      elevation: 5.0,
      highlightElevation: 6.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100.0),
      ),
      onPressed: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => CartPage())),
      backgroundColor: AppColors.mainColor,
      child: Center(
        child: Icon(
          Icons.shopping_cart_outlined,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
    return Scaffold(
      backgroundColor: AppColors.scfBgColor,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: Text(
          "Products",
          style: TextStyle(
              fontSize: 24,
              color: Color(0xff3D3D3D),
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      floatingActionButton: floatButton,
      body: Consumer<ProductViewModel>(
        builder: (context, productViewModel, child) {
          switch (productViewModel.state) {
            case ProductState.loading:
              return Center(child: CircularProgressIndicator());

            case ProductState.success:
              return ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  thickness: 0.2,
                  height: 0.2,
                ),
                itemCount: productViewModel.products.length,
                itemBuilder: (context, index) {
                  Product product = productViewModel.products[index];
                  return ListTile(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => ProductDetailView(
                              selectedProduct: product,
                            ))),
                    tileColor: Colors.white,
                    leading: SizedBox(
                      height: 60,
                      width: 30,
                      child: Image.network(
                        product.image,
                        fit: BoxFit.contain,
                      ),
                    ),
                    title: Text(
                      product.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff3D3D3D)),
                    ),
                    //  subtitle: Text("Price: \$${product.price.toString()}"),
                    subtitle: RichText(
                        text: TextSpan(
                            text: "Price: ",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                            children: [
                          TextSpan(
                              text: "\$${product.price.toString()}",
                              style: TextStyle(
                                  fontSize: 14, color: AppColors.mainColor))
                        ])),
                  );
                },
              );

            case ProductState.empty:
              return CustomNoproducts();

            case ProductState.error:
              return CustomServerError();

            case ProductState.connectionFailed:
              return ConnectFailed();
          }
        },
      ),
    );
  }
}
