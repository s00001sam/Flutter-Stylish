import 'package:flutter/material.dart';
import 'package:stylish_flutter_sam/dataprovider/repo/stylish_repository.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getCartProducts();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Image.asset(
          "assets/images/ic_stylish_logo.png",
          fit: BoxFit.contain,
          width: 130,
        ),
        centerTitle: true,
        backgroundColor: const Color(0xffe1e1e1),
      ),
      body: Container(),
    );
  }
}

void getCartProducts() {
  StylishRepository repository = StylishRepository();
  repository.getProductsInCart().then((products) {
    print(products);
  });
}
