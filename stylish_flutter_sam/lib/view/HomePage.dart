import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_flutter_sam/bloc/Home/home_bloc.dart';
import 'package:stylish_flutter_sam/view/ProductContentPage.dart';

import '../data/HomeItem.dart';
import '../util/Util.dart';

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
      body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        if (state is HomeLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is HomeErrorState) {
          return Center(
            child: Text(state.errorMsg),
          );
        }
        if (state is HomeSuccessState) {
          var bannerList = state.homeDatum?.bannerClothes ?? [];
          var categoryMap = state.homeDatum?.categoriesMap() ?? {};

          return Column(
            children: [
              HomeBanner(list: bannerList),
              const SizedBox(height: 8.0),
              HomeCategories(map: categoryMap),
            ],
          );
        }
        return Container();
      }),
    );
  }
}

class HomeBanner extends StatelessWidget {
  final List<HomeProduct>? list;

  const HomeBanner({
    required this.list,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (list == null) return Container();
    return Container(
      margin: const EdgeInsets.only(top: 8),
      height: 200,
      child: _horizontalList(list!),
    );
  }

  ListView _horizontalList(List<HomeProduct> list) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return BannerCard(product: list[index]);
        });
  }
}

class BannerCard extends StatelessWidget {
  final HomeProduct? product;

  const BannerCard({
    required this.product,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var image = product?.image ?? "";
    var id = product?.id ?? "";

    return SizedBox(
      width: 300,
      child: InkWell(
        onTap: () {
          goProductContent(context, id);
        },
        child: Card(
          semanticContainer: true,
          margin: const EdgeInsets.all(8.0),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Image.asset(
            image,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}

class HomeCategories extends StatelessWidget {
  Map<CategoryType, List<HomeProduct>>? map;

  HomeCategories({required this.map, super.key});

  @override
  Widget build(BuildContext context) {
    if (map == null) return Container();

    var womenClothes = map?[CategoryType.women] ?? [];
    var menClothes = map?[CategoryType.men] ?? [];
    var accessories = map?[CategoryType.accessory] ?? [];

    if (isPhoneDevice(context)) {
      return HomePhoneCategories(womenClothes, menClothes, accessories);
    }
    return HomeWebCategories(womenClothes, menClothes, accessories);
  }
}

class HomePhoneCategories extends StatefulWidget {
  final List<HomeProduct> womenClothes;
  final List<HomeProduct> menClothes;
  final List<HomeProduct> accessories;

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
    List<HomeItem> categories = [];
    int womenTitleIndex = -1;
    int menTitleIndex = -1;
    int otherTitleIndex = -1;
    List<HomeProduct> womenClothes = widget.womenClothes;
    List<HomeProduct> menClothes = widget.menClothes;
    List<HomeProduct> accessories = widget.accessories;

    if (womenClothes.isNotEmpty) {
      womenTitleIndex = 0;
      categories.add(HomeCategoryTitle("女裝"));
      if (isWomenExpanded) categories.addAll(womenClothes);
    }
    if (menClothes.isNotEmpty) {
      menTitleIndex = categories.length;
      categories.add(HomeCategoryTitle("男裝"));
      if (isMenExpanded) categories.addAll(menClothes);
    }
    if (accessories.isNotEmpty) {
      otherTitleIndex = categories.length;
      categories.add(HomeCategoryTitle("配件"));
      if (isAccessoriesExpanded) categories.addAll(accessories);
    }

    return Expanded(
        child: ListView.builder(
      itemCount: categories.length,
      physics: const BouncingScrollPhysics(),
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
        HomeProduct product = categories[index] as HomeProduct;
        return CategoryCardView(product);
      },
    ));
  }
}

class HomeWebCategories extends StatefulWidget {
  final List<HomeProduct> womenClothes;
  final List<HomeProduct> menClothes;
  final List<HomeProduct> accessories;

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
    final List<HomeProduct> womenClothes = widget.womenClothes;
    final List<HomeProduct> menClothes = widget.menClothes;
    final List<HomeProduct> accessories = widget.accessories;

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
    List<HomeProduct> categories,
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

  Expanded _list(List<HomeProduct> categories) {
    return Expanded(
      child: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          HomeProduct product = categories[index];
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
  late HomeProduct product;

  CategoryCardView(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    var id = product.id;

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 120,
      child: InkWell(
        onTap: () {
          goProductContent(context, id);
        },
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
      ),
    );
  }
}

void goProductContent(
  BuildContext context,
  String productId,
) {
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => ProductContentPage(productId: productId)),
  );
}
