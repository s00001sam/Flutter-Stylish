import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_flutter_sam/bloc/content/content_selector_cubit.dart';
import 'package:stylish_flutter_sam/bloc/content/product_content_bloc.dart';
import 'package:stylish_flutter_sam/data/ProductContent.dart';
import 'package:stylish_flutter_sam/view/tappay_page.dart';

import '../util/util.dart';

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
        .add(ProductContentLoadEvent(productId: int.parse(productId)));

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
    var isPhone = isPhoneDevice(context);

    return Container(
      constraints: const BoxConstraints(maxWidth: 800),
      child: CustomScrollView(
        slivers: [
          if (isPhone)
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16),
                child: TopImageSection(product: product),
              ),
            ),
          if (isPhone)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: NameAndSelectorSection(product: product),
              ),
            ),
          if (!isPhone)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: WebTopSection(product: product),
              ),
            ),
          DescriptionSection(product: product),
          ImagesSection(images: product?.images ?? []),
        ],
      ),
    );
  }
}

class WebTopSection extends StatelessWidget {
  final ProductContent? product;

  const WebTopSection({required this.product, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
            child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: TopImageSection(product: product),
        )),
        const SizedBox(width: 32.0),
        Flexible(child: NameAndSelectorSection(product: product)),
      ],
    );
  }
}

class TopImageSection extends StatelessWidget {
  final ProductContent? product;

  const TopImageSection({required this.product, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (product == null) return Container();
    context.read<ContentSelectorCubit>().init(product);

    var image = product?.mainImage ?? "";

    return SizedBox(
      child: AspectRatio(
        aspectRatio: 2 / 3,
        child: CachedNetworkImage(
          fit: BoxFit.fill,
          imageUrl: image,
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}

class NameAndSelectorSection extends StatelessWidget {
  final ProductContent? product;

  const NameAndSelectorSection({required this.product, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (product == null) return Container();
    var name = product?.name ?? "";
    var uid = product?.productId ?? "";
    var price = "NT\$ ${product?.price}";
    var colors = product?.colors() ?? [];

    return BlocBuilder<ContentSelectorCubit, ContentSelectorState>(
      builder: (context, state) {
        print('count..=${state.selectedCount}');
        return Column(
          children: [
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
            const Divider(height: 32, color: Colors.transparent),
            ColorSelector(colors: colors),
            const Divider(height: 32, color: Colors.transparent),
            SizeSelector(
              sizes: state.sizes,
              selectedColorCode: state.selectedColor,
              selectedSize: state.selectedSize,
            ),
            const Divider(height: 32, color: Colors.transparent),
            CountSelector(
              totalCount: state.totalCount,
              selectedColor: state.selectedColor,
              selectedSize: state.selectedSize,
              selectedCont: state.selectedCount,
            ),
            const Divider(height: 32, color: Colors.transparent),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  goTappay(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // Background color
                ),
                child: Text(state.selectedCount > 0 ? "加入購物車" : "請選擇尺寸"),
              ),
            ),
          ],
        );
      },
    );
  }
}

class ColorSelector extends StatelessWidget {
  final List<String> colors;

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

  Widget _colorList(List<String> colors) {
    return Expanded(
      child: SizedBox(
        height: 16,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: colors.length,
          itemBuilder: (BuildContext context, int index) {
            var currColorCode = colors[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: InkWell(
                onTap: () {
                  context
                      .read<ContentSelectorCubit>()
                      .selectColor(currColorCode);
                },
                child: Container(
                  width: 16,
                  decoration: BoxDecoration(
                    color: currColorCode.toColor(),
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
  final String? selectedColorCode;
  final ProductSize? selectedSize;

  const SizeSelector({
    required this.sizes,
    required this.selectedColorCode,
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
          _sizeList(context, sizes, selectedColorCode, selectedSize),
        ],
      ),
    );
  }

  Widget _sizeList(
    BuildContext context,
    List<ProductSize> sizes,
    String? selectedColorCode,
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
                selectedColorCode,
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
    String? selectedColorCode,
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
          if (selectedColorCode == null) return;
          context
              .read<ContentSelectorCubit>()
              .selectSize(selectedColorCode, size);
        },
        child: Center(child: Text(sizeText)),
      ),
    );
  }
}

class CountSelector extends StatefulWidget {
  final int totalCount;
  final String? selectedColor;
  final ProductSize? selectedSize;
  final int selectedCont;

  const CountSelector({
    required this.totalCount,
    required this.selectedColor,
    required this.selectedSize,
    required this.selectedCont,
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
    var selectedCont = widget.selectedCont;
    var selectCountStr = selectedCont <= 0 ? '' : selectedCont.toString();
    _countController.text = selectCountStr;

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
            margin: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: image,
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          );
        },
        childCount: images.length, // 1000 list items
      ),
    );
  }
}

void goTappay(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const TappayPage(),
    ),
  );
}
