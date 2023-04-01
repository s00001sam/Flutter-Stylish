import 'package:flutter/material.dart';

class ProductContentPage extends StatelessWidget {
  const ProductContentPage({
    required this.productId,
    Key? key,
  }) : super(key: key);

  final String productId;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(productId),
    );
  }
}
