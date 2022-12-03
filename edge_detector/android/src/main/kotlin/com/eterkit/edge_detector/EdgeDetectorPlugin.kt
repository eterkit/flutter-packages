package com.eterkit.edge_detector

import android.content.Context
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

/** EdgeDetectorPlugin */
class EdgeDetectorPlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel
    private lateinit var context: Context
    private val methodChannelName = "eterkit.com/edge_detector"
    private val detectEdgesMethod = "detectEdges"

    private val mainScope = CoroutineScope(Dispatchers.Main)

    private val edgeDetector = EdgeDetector()

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, methodChannelName)
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext;
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            detectEdgesMethod -> detectEdges(call, result)
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun detectEdges(@NonNull call: MethodCall, @NonNull result: Result) {
        val filePath: String =
            call.argument("filePath") ?: throw Exception("filePath can not be null")

        mainScope.launch {
            val edgeDetectorResult = withContext(Dispatchers.IO) {
                edgeDetector.detectEdges(context, filePath)
            }
            result.success(edgeDetectorResult.toJson())
        }
    }
}
