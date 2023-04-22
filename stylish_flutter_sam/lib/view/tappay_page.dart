import 'package:flutter/material.dart';
import 'package:stylish_flutter_sam/data/PrimeModel.dart';
import 'package:stylish_flutter_sam/util/tappay_channel_helper.dart';

class TappayPage extends StatelessWidget {
  const TappayPage({Key? key}) : super(key: key);

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
      body: const DirectPayContainer(),
    );
  }
}

class DirectPayContainer extends StatelessWidget {
  const DirectPayContainer({Key? key}) : super(key: key);
  final int appId = 12348;
  final String appKey =
      'app_pa1pQcKoY22IlnSXq5m5WP5jFKzoRG58VEXpT7wU62ud7mMbDOGzCYIlzzLF';
  final String cardNumber = '4111111111111111';
  final String dueMonth = '01';
  final String dueYear = '24';
  final String ccv = '123';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 36),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('current info'),
                Text("appId: $appId"),
                Text("appKey: $appKey"),
                Text("cardNumber: $cardNumber"),
                Text("dueMonth: $dueMonth"),
                Text("dueYear: $dueYear"),
                Text("ccv: $ccv"),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            color: Colors.blue,
            child: ElevatedButton(
              onPressed: () {
                TappayChannelHelper.setupTappay(
                    appId: appId,
                    appKey: appKey,
                    serverType: TappayServerType.sandBox,
                    errorMessage: (error) {
                      print(error);
                      toast(context, error);
                    });
              },
              child: const Text('Setup Tappay'),
            ),
          ),
          const SizedBox(height: 36),
          Container(
            color: Colors.blue,
            child: ElevatedButton(
              onPressed: () async {
                var isCardValid = await TappayChannelHelper.isCardValid(
                  cardNumber: cardNumber,
                  dueMonth: dueMonth,
                  dueYear: dueYear,
                  ccv: ccv,
                );
                print('isCardValid: $isCardValid');
                if (context.mounted) {
                  toast(context, 'isCardValid: $isCardValid');
                }
              },
              child: const Text('Is card valid?'),
            ),
          ),
          const SizedBox(height: 36),
          Container(
            color: Colors.blue,
            child: ElevatedButton(
              onPressed: () async {
                PrimeModel prime = await TappayChannelHelper.getPrime(
                  cardNumber: cardNumber,
                  dueMonth: dueMonth,
                  dueYear: dueYear,
                  ccv: ccv,
                );
                if (prime.prime == null || prime.prime?.isEmpty == true) {
                  print('status: ${prime.status}, message: ${prime.message}');
                  if (context.mounted) {
                    toast(context,
                        'status: ${prime.status}, message: ${prime.message}');
                  }
                } else {
                  print('prime: ${prime.prime}');
                  if (context.mounted) {
                    toast(context, 'prime: ${prime.prime}');
                  }
                }
              },
              child: const Text('Get prime'),
            ),
          ),
        ],
      ),
    );
  }

  void toast(BuildContext context, String s) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(s),
    ));
  }
}
