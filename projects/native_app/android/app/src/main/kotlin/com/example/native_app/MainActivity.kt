package com.example.native_app

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {

    private val CHANNEL = "native/sum"
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "sum" -> {
                    val num1 = call.argument<Int>("num1")?.toInt() ?: 0
                    val num2 = call.argument<Int>("num2")?.toInt() ?: 0

                    result.success(num1 + num2)
                }

                else -> result.notImplemented()
            }
        }
    }
}
