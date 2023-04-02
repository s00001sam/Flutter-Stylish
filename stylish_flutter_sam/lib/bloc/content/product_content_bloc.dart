import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stylish_flutter_sam/data/ProductContent.dart';

import '../../repo/StylishRepository.dart';

part 'product_content_event.dart';

part 'product_content_state.dart';

class ProductContentBloc
    extends Bloc<ProductContentEvent, ProductContentState> {
  final StylishRepository _repository;

  ProductContentBloc(this._repository) : super(ProductContentInitial()) {
    on<ProductContentLoadEvent>((event, emit) async {
      emit(ProductContentLoadingState());
      try {
        var datum = await _repository.getProductContent(event.productId);
        emit(ProductContentSuccessState(datum));
      } catch (e) {
        emit(ProductContentErrorState(e.toString()));
      }
    });
  }
}
