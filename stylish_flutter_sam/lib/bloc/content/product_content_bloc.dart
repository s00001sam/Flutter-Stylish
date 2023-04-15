import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:stylish_flutter_sam/data/ProductContent.dart';

import '../../api/repo/stylish_repository.dart';

part 'product_content_event.dart';

part 'product_content_state.dart';

class ProductContentBloc
    extends Bloc<ProductContentEvent, ProductContentState> {
  final StylishRepository _repository;

  ProductContentBloc(this._repository) : super(ProductContentInitial()) {
    on<ProductContentLoadEvent>((event, emit) async {
      emit(ProductContentLoadingState());
      try {
        var apiDatum = await _repository.getProductContent(event.productId);
        var datum = apiDatum.apiProduct.toProductContent();
        emit(ProductContentSuccessState(datum));
      } catch (e) {
        emit(ProductContentErrorState(e.toString()));
      }
    });
  }
}
