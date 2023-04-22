import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:stylish_flutter_sam/data/PrimeModel.dart';

const String METHOD_SET_UP_TAPPAY = "METHOD_SET_UP_TAPPAY";
const String METHOD_IS_CARD_VALID = "METHOD_IS_CARD_VALID";
const String METHOD_GET_PRIME = "METHOD_GET_PRIME";

class TappayChannelHelper {
  static const String TAPPAY_PLUGIN_CHANNEL = 'TAPPAY_PLUGIN_CHANNEL';

  static const MethodChannel _channel = MethodChannel(TAPPAY_PLUGIN_CHANNEL);

  //設置Tappay環境
  static Future<void> setupTappay({
    required int appId,
    required String appKey,
    required TappayServerType serverType,
    required Function(String) errorMessage,
  }) async {
    String st = '';
    switch (serverType) {
      case TappayServerType.sandBox:
        st = 'sandBox';
        break;
      case TappayServerType.production:
        st = 'production';
        break;
    }

    final String? error = await _channel.invokeMethod(
      METHOD_SET_UP_TAPPAY,
      {
        'appId': appId,
        'appKey': appKey,
        'serverType': st,
      },
    );

    if (error != null) {
      errorMessage(error);
    }
  }

  //檢查信用卡的有效性
  static Future<bool> isCardValid({
    required String cardNumber,
    required String dueMonth,
    required String dueYear,
    required String ccv,
  }) async {
    final bool isValid = await _channel.invokeMethod(
      METHOD_IS_CARD_VALID,
      {
        'cardNumber': cardNumber,
        'dueMonth': dueMonth,
        'dueYear': dueYear,
        'ccv': ccv,
      },
    );
    return isValid;
  }

  //取得Prime
  static Future<PrimeModel> getPrime({
    required String cardNumber,
    required String dueMonth,
    required String dueYear,
    required String ccv,
  }) async {
    String response = await _channel.invokeMethod(
      METHOD_GET_PRIME,
      {
        'cardNumber': cardNumber,
        'dueMonth': dueMonth,
        'dueYear': dueYear,
        'ccv': ccv,
      },
    );

    return PrimeModel.fromJson(json.decode(response));
  }
}

enum TappayServerType { sandBox, production }
