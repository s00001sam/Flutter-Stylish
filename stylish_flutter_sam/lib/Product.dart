
abstract class CategoryItem {
  late String name;
}

class Product implements CategoryItem {
  @override
  late String name;
  late int price;
  late String image;

  Product(this.name, this.price, this.image);
}

class CategoryTitle implements CategoryItem {
  @override
  late String name;

  CategoryTitle(this.name);
}
