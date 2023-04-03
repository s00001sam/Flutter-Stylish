import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_flutter_sam/bloc/Home/home_bloc.dart';
import 'package:stylish_flutter_sam/bloc/content/content_selector_cubit.dart';
import 'package:stylish_flutter_sam/bloc/content/product_content_bloc.dart';
import 'package:stylish_flutter_sam/data/ProductContent.dart';

class ProductContentPage extends StatelessWidget {
  const ProductContentPage({
    required this.productId,
    Key? key,
  }) : super(key: key);

  final String productId;

  @override
  Widget build(BuildContext context) {
    context
        .read<ProductContentBloc>()
        .add(ProductContentLoadEvent(productId: productId));

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ContentSelectorCubit(),
        ),
      ],
      child: Scaffold(
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
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: BlocBuilder<ProductContentBloc, ProductContentState>(
              builder: (context, state) {
            if (state is ProductContentLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ProductContentErrorState) {
              return Center(
                child: Text(state.errorMsg),
              );
            }
            if (state is ProductContentSuccessState) {
              return Center(
                child: ProductContentContainer(product: state.content),
              );
            }
            return Container();
          }),
        ),
      ),
    );
  }
}

class ProductContentContainer extends StatelessWidget {
  final ProductContent? product;

  const ProductContentContainer({
    required this.product,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (product == null) {
      return const Center(
        child: Text("not found"),
      );
    }

    return CustomScrollView(
      slivers: [
        ContentTopInfo(product: product),
        ContentSelectorSection(product: product),
        DescriptionSection(product: product),
        ImagesSection(images: product?.images ?? []),
      ],
    );
  }
}

class ContentTopInfo extends StatelessWidget {
  final ProductContent? product;

  const ContentTopInfo({required this.product, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (product == null) return Container();
    context.read<ContentSelectorCubit>().init(product);

    var image = product?.images.first ?? "";
    var name = product?.name ?? "";
    var uid = product?.uid ?? "";
    var price = "NT\$ ${product?.price}";
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16),
        child: Column(
          children: [
            SizedBox(height: 500, child: Image.asset(image, fit: BoxFit.fill)),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                uid,
                textAlign: TextAlign.left,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
                top: 24,
                bottom: 16,
              ),
              child: Text(
                price,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            const Divider(height: 1.0, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

class ContentSelectorSection extends StatelessWidget {
  final ProductContent? product;

  const ContentSelectorSection({required this.product, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (product == null) return Container();

    var colors = product?.colors() ?? [];

    return BlocBuilder<ContentSelectorCubit, ContentSelectorState>(
      builder: (context, state) {
        return SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              children: [
                ColorSelector(colors: colors),
                const Divider(height: 32, color: Colors.transparent),
                SizeSelector(
                  sizes: state.sizes,
                  selectedColorInt: state.selectedColor,
                  selectedSize: state.selectedSize,
                ),
                const Divider(height: 32, color: Colors.transparent),
                CountSelector(
                  totalCount: state.totalCount,
                  selectedColor: state.selectedColor,
                  selectedSize: state.selectedSize,
                ),
                const Divider(height: 32, color: Colors.transparent),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, // Background color
                    ),
                    child: Text(state.selectedCount > 0 ? "加入購物車" : "請選擇尺寸"),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ColorSelector extends StatelessWidget {
  final List<int> colors;

  const ColorSelector({required this.colors, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          const Text("顏色"),
          const VerticalDivider(
            thickness: 1,
            color: Color(0x4A525252),
          ),
          _colorList(colors),
        ],
      ),
    );
  }

  Widget _colorList(List<int> colors) {
    return Expanded(
      child: SizedBox(
        height: 16,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: colors.length,
          itemBuilder: (BuildContext context, int index) {
            var currColorInt = colors[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: InkWell(
                onTap: () {
                  context
                      .read<ContentSelectorCubit>()
                      .selectColor(currColorInt);
                },
                child: Container(
                  width: 16,
                  decoration: BoxDecoration(
                    color: Color(currColorInt),
                    border: Border.all(color: Colors.grey, width: 0.5),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class SizeSelector extends StatelessWidget {
  final List<ProductSize> sizes;
  final int? selectedColorInt;
  final ProductSize? selectedSize;

  const SizeSelector({
    required this.sizes,
    required this.selectedColorInt,
    required this.selectedSize,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          const Text("尺寸"),
          const VerticalDivider(
            thickness: 1,
            color: Color(0x4A525252),
          ),
          _sizeList(context, sizes, selectedColorInt, selectedSize),
        ],
      ),
    );
  }

  Widget _sizeList(
    BuildContext context,
    List<ProductSize> sizes,
    int? selectedColorInt,
    ProductSize? selectedSize,
  ) {
    return Expanded(
      child: SizedBox(
        height: 36,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: sizes.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: _sizeCard(
                context,
                sizes[index],
                selectedColorInt,
                selectedSize,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _sizeCard(
    BuildContext context,
    ProductSize size,
    int? selectedColorInt,
    ProductSize? selectedSize,
  ) {
    String sizeText;
    switch (size) {
      case ProductSize.small:
        {
          sizeText = "S";
          break;
        }
      case ProductSize.medium:
        {
          sizeText = "M";
          break;
        }
      case ProductSize.large:
        {
          sizeText = "L";
          break;
        }
    }
    var containerColor = selectedSize == size ? Colors.amber : Colors.white;

    return Container(
      color: containerColor,
      width: 48,
      child: InkWell(
        onTap: () {
          if (selectedColorInt == null) return;
          context
              .read<ContentSelectorCubit>()
              .selectSize(selectedColorInt, size);
        },
        child: Center(child: Text(sizeText)),
      ),
    );
  }
}

class CountSelector extends StatefulWidget {
  final int totalCount;
  final int? selectedColor;
  final ProductSize? selectedSize;

  CountSelector({
    required this.totalCount,
    required this.selectedColor,
    required this.selectedSize,
    Key? key,
  }) : super(key: key);

  @override
  State<CountSelector> createState() => _CountSelectorState();
}

class _CountSelectorState extends State<CountSelector> {
  final TextEditingController _countController = TextEditingController();

  @override
  void initState() {
    _countController.addListener(() {
      var totalCount = widget.totalCount;
      var selectedColor = widget.selectedColor;
      var selectedSize = widget.selectedSize;
      var input = _countController.text;
      print(input);
      var inputCount = int.tryParse(input) ?? 0;
      if (input.startsWith("0") || totalCount == 0) {
        _countController.text = "";
      }
      if (inputCount > totalCount) {
        _countController.text = totalCount.toString();
      }
      if (inputCount <= totalCount) {
        if (selectedColor == null || selectedSize == null) return;
        context
            .read<ContentSelectorCubit>()
            .setSelectedCount(selectedColor, selectedSize, inputCount);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _countController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var totalCount = widget.totalCount;

    return IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          const Text("數量"),
          const VerticalDivider(
            thickness: 1,
            color: Color(0x4A525252),
          ),
          InkWell(
            onTap: () {
              var input = _countController.text;
              var inputCount = int.tryParse(input) ?? 0;
              if (inputCount <= 0) return;
              _countController.text = (inputCount - 1).toString();
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(Icons.remove_circle),
            ),
          ),
          Expanded(
            child: TextField(
              textAlign: TextAlign.center,
              maxLines: 1,
              controller: _countController,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: const InputDecoration(border: InputBorder.none),
            ),
          ),
          InkWell(
            onTap: () {
              var input = _countController.text;
              var inputCount = int.tryParse(input) ?? 0;
              print(inputCount);
              print(totalCount);
              if (inputCount >= totalCount) return;
              _countController.text = (inputCount + 1).toString();
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(Icons.add_circle),
            ),
          ),
        ],
      ),
    );
  }
}

class DescriptionSection extends StatelessWidget {
  final ProductContent? product;

  const DescriptionSection({required this.product, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (product == null) return Container();
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            children: [
              _topLine(),
              const Divider(height: 8.0, color: Colors.transparent),
              Text(product?.description ?? ""),
            ],
          ),
        ),
      ),
    );
  }

  Widget _topLine() {
    Gradient gradient = const LinearGradient(
      colors: [Colors.blueAccent, Colors.greenAccent],
    );
    Shader shader = gradient.createShader(const Rect.fromLTWH(0, 0, 100, 0));
    return Row(
      children: [
        Text(
          "細部說明",
          style: TextStyle(
            foreground: Paint()..shader = shader,
          ),
        ),
        Expanded(
          child: Container(
              margin: const EdgeInsets.only(left: 16.0),
              child: const Divider(
                color: Colors.black45,
                height: 2,
              )),
        ),
      ],
    );
  }
}

class ImagesSection extends StatelessWidget {
  final List<String> images;

  const ImagesSection({required this.images, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          var image = images[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
            height: 200,
            child: Image.asset(
              image,
              fit: BoxFit.fill,
            ),
          );
        },
        childCount: images.length, // 1000 list items
      ),
    );
  }
}
