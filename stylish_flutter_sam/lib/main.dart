import 'package:flutter/material.dart';

import 'MyCustomScrollBehavior.dart';
import 'Product.dart';
import 'Util.dart';

void main() {
  runApp(const StylishApp());
}

class StylishApp extends StatelessWidget {
  const StylishApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          HomeCategories()
        ],
      ),
    );
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

class HomeCategories extends StatelessWidget {
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

  HomeCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(isPhoneDevice(context)) {
      return HomePhoneCategories(womenClothes, menClothes, accessories);
    }
    return HomeWebCategories(womenClothes, menClothes, accessories);
  }
}

class HomePhoneCategories extends StatefulWidget {
  final List<Product> womenClothes;
  final List<Product> menClothes;
  final List<Product> accessories;

  const HomePhoneCategories(
      this.womenClothes, this.menClothes, this.accessories,
      {super.key});

  @override
  State<HomePhoneCategories> createState() => _HomePhoneCategoriesState();
}

class _HomePhoneCategoriesState extends State<HomePhoneCategories> {
  bool isWomenExpanded = true;
  bool isMenExpanded = true;
  bool isAccessoriesExpanded = true;

  @override
  Widget build(BuildContext context) {
    List<CategoryItem> categories = [];
    int womenTitleIndex = -1;
    int menTitleIndex = -1;
    int otherTitleIndex = -1;
    List<Product> womenClothes = widget.womenClothes;
    List<Product> menClothes = widget.menClothes;
    List<Product> accessories = widget.accessories;

    if (womenClothes.isNotEmpty) {
      womenTitleIndex = 0;
      categories.add(CategoryTitle("女裝"));
      if (isWomenExpanded) categories.addAll(womenClothes);
    }
    if (menClothes.isNotEmpty) {
      menTitleIndex = categories.length;
      categories.add(CategoryTitle("男裝"));
      if (isMenExpanded) categories.addAll(menClothes);
    }
    if (accessories.isNotEmpty) {
      otherTitleIndex = categories.length;
      categories.add(CategoryTitle("配件"));
      if (isAccessoriesExpanded) categories.addAll(accessories);
    }

    return Expanded(
        child: ListView.builder(
      itemCount: categories.length,
      itemBuilder: (BuildContext context, int index) {
        if (index == womenTitleIndex ||
            index == menTitleIndex ||
            index == otherTitleIndex) {
          return CategoryTitleView(
            title: categories[index].name,
            onTap: () {
              setState(() {
                if (index == womenTitleIndex) {
                  isWomenExpanded = !isWomenExpanded;
                }
                if (index == menTitleIndex) {
                  isMenExpanded = !isMenExpanded;
                }
                if (index == otherTitleIndex) {
                  isAccessoriesExpanded = !isAccessoriesExpanded;
                }
              });
            },
          );
        }
        Product product = categories[index] as Product;
        return CategoryCardView(product);
      },
    ));
  }
}

class HomeWebCategories extends StatefulWidget {
  final List<Product> womenClothes;
  final List<Product> menClothes;
  final List<Product> accessories;

  const HomeWebCategories(this.womenClothes, this.menClothes, this.accessories,
      {super.key});

  @override
  State<HomeWebCategories> createState() => _HomeWebCategoriesState();
}

class _HomeWebCategoriesState extends State<HomeWebCategories> {
  bool isWomenExpanded = true;
  bool isMenExpanded = true;
  bool isAccessoriesExpanded = true;

  @override
  Widget build(BuildContext context) {
    final List<Product> womenClothes = widget.womenClothes;
    final List<Product> menClothes = widget.menClothes;
    final List<Product> accessories = widget.accessories;

    return Expanded(
      child: Row(
        children: [
          _listWithTitle("女裝", womenClothes),
          _listWithTitle("男裝", menClothes),
          _listWithTitle("配件", accessories),
        ],
      ),
    );
  }

  Expanded _listWithTitle(
    String title,
    List<Product> categories,
  ) {
    return Expanded(
        child: Column(
      children: [
        CategoryTitleView(
          title: title,
          onTap: () {
            setState(() {
              if (title == "女裝") isWomenExpanded = !isWomenExpanded;
              if (title == "男裝") isMenExpanded = !isMenExpanded;
              if (title == "配件") isAccessoriesExpanded = !isAccessoriesExpanded;
            });
          },
        ),
        if (title == "女裝" && isWomenExpanded ||
            title == "男裝" && isMenExpanded ||
            title == "配件" && isAccessoriesExpanded)
          _list(categories),
      ],
    ));
  }

  Expanded _list(List<Product> categories) {
    return Expanded(
      child: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          Product product = categories[index];
          return CategoryCardView(product);
        },
      ),
    );
  }
}

class CategoryTitleView extends StatelessWidget {
  final String title;
  final Function() onTap;

  const CategoryTitleView(
      {required this.title, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: InkWell(
      onTap: onTap,
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ));
  }
}

class CategoryCardView extends StatelessWidget {
  Product product;

  CategoryCardView(this.product, {super.key});

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
