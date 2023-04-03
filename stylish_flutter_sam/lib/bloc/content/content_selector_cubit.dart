import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stylish_flutter_sam/data/ProductContent.dart';

import '../../repo/StylishRepository.dart';

part 'content_selector_state.dart';

class ContentSelectorCubit extends Cubit<ContentSelectorState> {
  ProductContent? content;
  ContentSelectorCubit() : super(ContentSelectorInitial());

  void init(ProductContent? content) {
    this.content = content;
  }

  void selectColor(int colorInt) {
    if(content == null) return;

    var sizes = content?.sizesByColor(colorInt) ?? [];

    emit(ContentSelectorState(
      selectedColor: colorInt,
      sizes: sizes,
      selectedSize: null,
      totalCount: 0,
      selectedCount: 0,
    ));
  }

  void selectSize(int colorInt, ProductSize size) {
    if(content == null) return;

    var sizes = content?.sizesByColor(colorInt) ?? [];
    var totalCount = content?.totalCountByColorSize(colorInt, size) ?? 0;

    emit(ContentSelectorState(
      selectedColor: colorInt,
      sizes: sizes,
      selectedSize: size,
      totalCount: totalCount,
      selectedCount: 0,
    ));
  }

  void setSelectedCount(int colorInt, ProductSize size, int count) {
    if(content == null) return;

    var sizes = content?.sizesByColor(colorInt) ?? [];
    var totalCount = content?.totalCountByColorSize(colorInt, size) ?? 0;

    emit(ContentSelectorState(
      selectedColor: colorInt,
      sizes: sizes,
      selectedSize: size,
      totalCount: totalCount,
      selectedCount: count,
    ));
  }
}
