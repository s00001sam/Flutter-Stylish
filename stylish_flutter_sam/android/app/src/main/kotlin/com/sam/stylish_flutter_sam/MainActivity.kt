package com.sam.stylish_flutter_sam

import com.sam.stylish_flutter_sam.TappayHelper.getPrime
import com.sam.stylish_flutter_sam.TappayHelper.isCardValid
import com.sam.stylish_flutter_sam.TappayHelper.setupTappay
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        val binaryMessenger = flutterEngine.dartExecutor.binaryMessenger
        MethodChannel(binaryMessenger, SAM_STYLISH_CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == PASS_PLATFORM_DATA) {
                val str = "I'm Sam"
                result.success(str)
            } else {
                result.notImplemented()
            }
        }
        MethodChannel(binaryMessenger, TAPPAY_PLUGIN_CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                METHOD_SET_UP_TAPPAY -> {
                    val appId: Int? = call.argument("appId")
                    val appKey: String? = call.argument("appKey")
                    val serverType: String? = call.argument("serverType")
                    setupTappay(
                        this@MainActivity,
                        appId,
                        appKey,
                        serverType,
                        errorMessage = { result.error("", it, "") },
                    )
                }
                METHOD_IS_CARD_VALID -> {
                    val cardNumber: String? = call.argument("cardNumber")
                    val dueMonth: String? = call.argument("dueMonth")
                    val dueYear: String? = call.argument("dueYear")
                    val ccv: String? = call.argument("ccv")
                    result.success(isCardValid(cardNumber, dueMonth, dueYear, ccv))
                }
                METHOD_GET_PRIME -> {
                    val cardNumber: String? = call.argument("cardNumber")
                    val dueMonth: String? = call.argument("dueMonth")
                    val dueYear: String? = call.argument("dueYear")
                    val ccv: String? = call.argument("ccv")
                    getPrime(
                        context = this@MainActivity,
                        cardNumber = cardNumber,
                        dueMonth = dueMonth,
                        dueYear = dueYear,
                        ccv = ccv,
                        prime = {
                            result.success(it)
                        },
                        failCallBack = {
                            result.success(it)
                        },
                    )
                }
            }
        }
    }

    companion object {
        private const val SAM_STYLISH_CHANNEL = "SAM_STYLISH_CHANNEL"
        private const val PASS_PLATFORM_DATA = "PASS_PLATFORM_DATA"
        private const val TAPPAY_PLUGIN_CHANNEL = "TAPPAY_PLUGIN_CHANNEL"
        private const val METHOD_SET_UP_TAPPAY = "METHOD_SET_UP_TAPPAY"
        private const val METHOD_IS_CARD_VALID = "METHOD_IS_CARD_VALID"
        private const val METHOD_GET_PRIME = "METHOD_GET_PRIME"
    }
}
