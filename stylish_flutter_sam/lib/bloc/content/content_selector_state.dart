part of 'content_selector_cubit.dart';

class ContentSelectorState {
  int? selectedColor;
  List<ProductSize> sizes = [];
  ProductSize? selectedSize;
  int totalCount = 0;
  int selectedCount = 0;

  ContentSelectorState({
    this.selectedColor,
    required this.sizes,
    this.selectedSize,
    required this.totalCount,
    required this.selectedCount,
  });
}

class ContentSelectorInitial extends ContentSelectorState {
  ContentSelectorInitial() : super(sizes: [], totalCount: 0, selectedCount: 0);
}
