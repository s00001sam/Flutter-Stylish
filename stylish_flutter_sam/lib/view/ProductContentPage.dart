import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_flutter_sam/bloc/Home/home_bloc.dart';
import 'package:stylish_flutter_sam/bloc/content/product_content_bloc.dart';
import 'package:stylish_flutter_sam/data/ProductContent.dart';

class ProductContentPage extends StatelessWidget {
  const ProductContentPage({
    required this.productId,
    Key? key,
  }) : super(key: key);

  final String productId;

  @override
  Widget build(BuildContext context) {
    context
        .read<ProductContentBloc>()
        .add(ProductContentLoadEvent(productId: productId));

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
      body: BlocBuilder<ProductContentBloc, ProductContentState>(
          builder: (context, state) {
        if (state is ProductContentLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ProductContentErrorState) {
          return Center(
            child: Text(state.errorMsg),
          );
        }
        if (state is ProductContentSuccessState) {
          return Center(
            child: Text(state.content?.name ?? "empty"),
          );
        }
        return Container();
      }),
    );
  }
}
