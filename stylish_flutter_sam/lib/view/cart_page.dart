import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_flutter_sam/bloc/cart/cart_cubit.dart';
import 'package:stylish_flutter_sam/data/DBProduct.dart';
import 'package:stylish_flutter_sam/data/PrimeModel.dart';
import 'package:stylish_flutter_sam/dataprovider/repo/stylish_repository.dart';
import 'package:stylish_flutter_sam/util/tappay_channel_helper.dart';
import 'package:stylish_flutter_sam/util/util.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StylishRepository repository = StylishRepository();
    const int appId = 12348;
    const String appKey =
        'app_pa1pQcKoY22IlnSXq5m5WP5jFKzoRG58VEXpT7wU62ud7mMbDOGzCYIlzzLF';
    TappayChannelHelper.setupTappay(
        appId: appId,
        appKey: appKey,
        serverType: TappayServerType.sandBox,
        errorMessage: (error) {
          toast(context, error);
        });

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
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => CartCubit(repository)..load(),
          ),
        ],
        child: BlocBuilder<CartCubit, CartState>(builder: (context, state) {
          if (state is CartLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CartErrorState) {
            return Center(
              child: Text(state.errorMsg),
            );
          }
          if (state is CartSuccessState) {
            var products = state.products;
            if (products.isEmpty) {
              return const Center(
                child: Text('Cart is empty!'),
              );
            }
            return CartContainer(products: products);
          }
          return Container();
        }),
      ),
    );
  }
}

class CartContainer extends StatelessWidget {
  final List<DBProduct> products;

  const CartContainer({required this.products, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        ProductsSection(products: products),
        TotalPrizeSection(products: products),
        const PaySection(),
      ],
    );
  }
}

class ProductsSection extends StatelessWidget {
  final List<DBProduct> products;

  const ProductsSection({required this.products, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          var product = products[index];
          return Container(
            margin:
                const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
            child: _productCard(context, product),
          );
        },
        childCount: products.length,
      ),
    );
  }

  Widget _productCard(BuildContext context, DBProduct product) {
    var id = product.id;
    var imageUrl = product.imageUrl;
    var name = product.name;
    var color = product.colorCode.toColor();
    var size = product.size;
    var prize = product.prize;
    var count = product.count;

    return Expanded(
      child: Row(
        children: [
          InkWell(
            onTap: () {
              if (id == null) return;
              context.read<CartCubit>().deleteProductFromCart(id);
            },
            child: const Icon(
              Icons.delete,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 24),
          SizedBox(
            width: 50,
            height: 70,
            child: CachedNetworkImage(
              fit: BoxFit.fill,
              imageUrl: imageUrl,
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: color,
                        border: Border.all(color: Colors.grey, width: 0.5),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(size),
                  ],
                ),
                const SizedBox(height: 8),
                Text('\$ $prize'),
              ],
            ),
          ),
          const SizedBox(width: 24),
          Text('$count'),
        ],
      ),
    );
  }
}

class TotalPrizeSection extends StatelessWidget {
  final List<DBProduct> products;

  const TotalPrizeSection({required this.products, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int totalPrize = 0;
    products.forEach((product) {
      totalPrize += product.getTotalPrize();
    });

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [Text('總計 \$ $totalPrize')],
        ),
      ),
    );
  }
}

class PaySection extends StatefulWidget {
  const PaySection({Key? key}) : super(key: key);

  @override
  State<PaySection> createState() => _PaySectionState();
}

class _PaySectionState extends State<PaySection> {
  @override
  Widget build(BuildContext context) {
    String cardNumber = '';
    String dueMonth = '';
    String dueYear = '';
    String ccv = '';

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 32, right: 32, top: 8, bottom: 64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('刷卡資訊'),
            const SizedBox(height: 8),
            TextField(
              textAlign: TextAlign.center,
              maxLines: 1,
              maxLength: 16,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
                hintText: '卡號',
              ),
              onChanged: (text) {
                print('card=$text');
                cardNumber = text;
                print('cardNumber=$cardNumber');
              },
            ),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 80,
                    child: TextField(
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      maxLength: 2,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                        hintText: '月份',
                      ),
                      onChanged: (text) {
                        print('dueMonth=$dueMonth cardNumber=$cardNumber');
                        dueMonth = text;
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: SizedBox(
                    height: 80,
                    child: TextField(
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      maxLength: 2,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                        hintText: '年份',
                      ),
                      onChanged: (text) {
                        dueYear = text;
                      },
                    ),
                  ),
                ),
                const Spacer(),
                Expanded(
                  child: SizedBox(
                    height: 80,
                    child: TextField(
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      maxLength: 3,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                        hintText: 'CCV',
                      ),
                      onChanged: (text) {
                        ccv = text;
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  await startToPay(context, cardNumber, dueMonth, dueYear, ccv);
                },
                child: const Text('付款'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> startToPay(
  BuildContext context,
  String cardNumber,
  String dueMonth,
  String dueYear,
  String ccv,
) async {
  if (cardNumber.isEmpty ||
      dueMonth.isEmpty ||
      dueYear.isEmpty ||
      ccv.isEmpty) {
    toast(context, 'input empty!');
    return;
  }

  var isCardValid = await TappayChannelHelper.isCardValid(
    cardNumber: cardNumber,
    dueMonth: dueMonth,
    dueYear: dueYear,
    ccv: ccv,
  );
  if (context.mounted) {
    toast(context, 'isCardValid: $isCardValid');
  }

  if (!isCardValid) return;
  PrimeModel prime = await TappayChannelHelper.getPrime(
    cardNumber: cardNumber,
    dueMonth: dueMonth,
    dueYear: dueYear,
    ccv: ccv,
  );
  if (prime.prime == null || prime.prime?.isEmpty == true) {
    if (context.mounted) {
      toast(context, 'status: ${prime.status}, message: ${prime.message}');
    }
  } else {
    if (context.mounted) {
      toast(context, 'prime: ${prime.prime}');
    }
  }
}

void toast(BuildContext context, String s) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(s),
  ));
}
