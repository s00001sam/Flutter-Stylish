part of 'cart_cubit.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoadingState extends CartState {}

class CartSuccessState extends CartState {
  final List<DBProduct> products;

  CartSuccessState(this.products);
}

class CartErrorState extends CartState {
  String errorMsg = "";

  CartErrorState(this.errorMsg);
}
