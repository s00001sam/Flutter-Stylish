import 'package:flutter/material.dart';

import 'Product.dart';

void main() {
  runApp(const StylishApp());
}

class StylishApp extends StatelessWidget {
  const StylishApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Image.asset(
            "assets/images/ic_stylish_logo.png",
            fit: BoxFit.contain,
            width: 130,
          ),
          centerTitle: true,
          backgroundColor: const Color(0xffe1e1e1),
        ),
        body: Column(
          children: [
            const HomeBanner(),
            const SizedBox(height: 8.0),
            HomePhoneCategories(),
          ],
        ));
  }
}

class HomeBanner extends StatelessWidget {
  const HomeBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      height: 200,
      child: _horizontalList(10),
    );
  }

  ListView _horizontalList(int n) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: List.generate(n, (i) => const BannerCard()),
    );
  }
}

class BannerCard extends StatelessWidget {
  const BannerCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Card(
        semanticContainer: true,
        margin: const EdgeInsets.all(8.0),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: Image.asset(
          "assets/images/ic_cloth_banner.jpg",
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

class HomePhoneCategories extends StatelessWidget {
  final List<Product> womenClothes = List<Product>.generate(
    12,
    (i) => Product("women", 200, "assets/images/ic_cloth_women.jpg"),
  );
  final List<Product> menClothes = List<Product>.generate(
    10,
    (i) => Product("men", 100, "assets/images/ic_cloth_men.jpg"),
  );
  final List<Product> accessories = List<Product>.generate(
    6,
    (i) => Product("accessory", 1000, "assets/images/ic_accessory.jpg"),
  );

  HomePhoneCategories({super.key});

  @override
  Widget build(BuildContext context) {
    List<CategoryItem> categories = [];
    int womenTitleIndex = -1;
    int menTitleIndex = -1;
    int otherTitleIndex = -1;
    if (womenClothes.isNotEmpty) {
      womenTitleIndex = 0;
      categories.add(CategoryTitle("女裝"));
      categories.addAll(womenClothes);
    }
    if (menClothes.isNotEmpty) {
      menTitleIndex = categories.length;
      categories.add(CategoryTitle("男裝"));
      categories.addAll(menClothes);
    }
    if (accessories.isNotEmpty) {
      otherTitleIndex = categories.length;
      categories.add(CategoryTitle("配件"));
      categories.addAll(accessories);
    }

    return Expanded(
        child: ListView.builder(
      itemCount: categories.length,
      itemBuilder: (BuildContext context, int index) {
        if (index == menTitleIndex ||
            index == womenTitleIndex ||
            index == otherTitleIndex) {
          return Center(child: Text(categories[index].name));
        }
        Product product = categories[index] as Product;
        return CategoryCard(product);
      },
    ));
  }
}

class CategoryCard extends StatelessWidget {
  Product product;

  CategoryCard(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 120,
      child: Card(
        semanticContainer: true,
        margin: const EdgeInsets.all(8.0),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.black45, width: 2),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8.0),
                bottomLeft: Radius.circular(8.0),
              ),
              child: Image.asset(
                product.image,
                width: 60,
                fit: BoxFit.fitHeight,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    "NT\$ ${product.price}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
