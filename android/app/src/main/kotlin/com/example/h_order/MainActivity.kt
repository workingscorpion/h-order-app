package com.example.h_order

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import androidx.annotation.NonNull
import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES
import android.provider.Settings

class MainActivity: FlutterActivity() {
  private val CHANNEL = "com.globalorder.h_order/deviceInfo"

  override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
      call, result ->

      when (call.method) {
        "getDeviceId" -> {
          val deviceId = getDeviceId()

          if (deviceId != "") {
            result.success(deviceId)
          } else {
            result.error("UNAVAILABLE", "Device id not available.", null)
          }
        }

        "getBatteryLevel" -> {
          val batteryLevel = getBatteryLevel()

          if (batteryLevel != -1) {
            result.success(batteryLevel)
          } else {
            result.error("UNAVAILABLE", "Battery level not available.", null)
          }
        }

        else -> result.notImplemented()
      }
    }
  }

  private fun getDeviceId(): String {
    return Settings.Secure.getString(applicationContext.contentResolver, Settings.Secure.ANDROID_ID);
  }

  private fun getBatteryLevel(): Int {
    if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
      val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
      return batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
    }

    val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
    return intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
  }
}
