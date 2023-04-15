import 'package:bloc/bloc.dart';
import 'package:stylish_flutter_sam/data/ProductContent.dart';

part 'content_selector_state.dart';

class ContentSelectorCubit extends Cubit<ContentSelectorState> {
  ProductContent? content;

  ContentSelectorCubit() : super(ContentSelectorInitial());

  void init(ProductContent? content) {
    this.content = content;
  }

  void selectColor(String colorCode) {
    if (content == null) return;

    var sizes = content?.sizesByColor(colorCode) ?? [];

    emit(ContentSelectorState(
      selectedColor: colorCode,
      sizes: sizes,
      selectedSize: null,
      totalCount: 0,
      selectedCount: 0,
    ));
  }

  void selectSize(String colorCode, ProductSize size) {
    if (content == null) return;

    var sizes = content?.sizesByColor(colorCode) ?? [];
    var totalCount = content?.totalCountByColorSize(colorCode, size) ?? 0;

    emit(ContentSelectorState(
      selectedColor: colorCode,
      sizes: sizes,
      selectedSize: size,
      totalCount: totalCount,
      selectedCount: 0,
    ));
  }

  void setSelectedCount(String colorCode, ProductSize size, int count) {
    if (content == null) return;

    var sizes = content?.sizesByColor(colorCode) ?? [];
    var totalCount = content?.totalCountByColorSize(colorCode, size) ?? 0;

    emit(ContentSelectorState(
      selectedColor: colorCode,
      sizes: sizes,
      selectedSize: size,
      totalCount: totalCount,
      selectedCount: count,
    ));
  }
}
