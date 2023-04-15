part of 'product_content_bloc.dart';

abstract class ProductContentEvent {}

class ProductContentLoadEvent extends ProductContentEvent {
  int productId;

  ProductContentLoadEvent({required this.productId});
}
