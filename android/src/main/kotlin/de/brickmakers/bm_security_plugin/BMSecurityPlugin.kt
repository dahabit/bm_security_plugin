package de.brickmakers.bm_security_plugin

import androidx.annotation.NonNull
import android.content.Context
import com.scottyab.rootbeer.RootBeer
import com.scottyab.rootbeer.util.QLog

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

/** BMSecurityPlugin */
class BMSecurityPlugin: FlutterPlugin, MethodCallHandler {
  private lateinit var channel : MethodChannel
  private lateinit var context: Context

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "bm_security_plugin")
    channel.setMethodCallHandler(this)
    this.context = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "deviceIsJailbroken") {
      val rootBeer = RootBeer(context)
      rootBeer.setLogging(false)
      var magiskDetected = MagiskDetect.detectMagisk(context)
      result.success(rootBeer.isRooted || magiskDetected)
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

}
