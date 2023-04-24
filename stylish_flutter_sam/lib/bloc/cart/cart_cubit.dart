import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_flutter_sam/data/DBProduct.dart';
import 'package:stylish_flutter_sam/dataprovider/repo/stylish_repository.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final StylishRepository _repository;

  CartCubit(this._repository) : super(CartInitial());

  Future<void> load() async {
    emit(CartLoadingState());
    try {
      var products = await _repository.getProductsInCart();
      emit(CartSuccessState(products));
    } catch (e) {
      emit(CartErrorState(e.toString()));
    }
  }

  Future<void> deleteProductFromCart(int id) async {
    try {
      await _repository.deleteFromCart(id);
      var products = await _repository.getProductsInCart();
      emit(CartSuccessState(products));
    } catch (e) {
      emit(CartErrorState(e.toString()));
    }
  }
}
