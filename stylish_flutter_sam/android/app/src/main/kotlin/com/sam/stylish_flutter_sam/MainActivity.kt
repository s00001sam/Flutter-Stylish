package com.sam.stylish_flutter_sam

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
    }

    companion object {
        private const val SAM_STYLISH_CHANNEL = "SAM_STYLISH_CHANNEL"
        private const val PASS_PLATFORM_DATA = "PASS_PLATFORM_DATA"
    }
}
