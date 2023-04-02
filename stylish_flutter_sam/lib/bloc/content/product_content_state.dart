part of 'product_content_bloc.dart';

abstract class ProductContentState {
  ProductContent? content;

  ProductContentState(this.content);
}

class ProductContentInitial extends ProductContentState {
  ProductContentInitial() : super(null);
}

class ProductContentLoadingState extends ProductContentState {
  ProductContentLoadingState() : super(null);
}

class ProductContentSuccessState extends ProductContentState {
  @override
  ProductContent? content;

  ProductContentSuccessState(this.content) : super(content);
}

class ProductContentErrorState extends ProductContentState {
  String errorMsg = "";

  ProductContentErrorState(this.errorMsg) : super(null);
}
