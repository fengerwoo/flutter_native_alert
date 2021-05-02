package com.fenger.native_alert.flutter_native_alert;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.widget.Toast;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;


/** FlutterNativeAlertPlugin */
public class FlutterNativeAlertPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private Activity activity;
  private AlertDialog alertDialog;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "flutter_native_alert");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull final Result result) {
    if (call.method.equals("showConfirm")) {
      String title = call.argument("title");
      String message = call.argument("message");
      String confirmButtonText = call.argument("confirmButtonText");
      String cancelButtonText = call.argument("cancelButtonText");

      AlertDialog.Builder dialog = new AlertDialog.Builder(this.activity, AlertDialog.THEME_DEVICE_DEFAULT_LIGHT);
      dialog.setTitle(title);
      dialog.setMessage(message);
      dialog.setCancelable(false);

      if(confirmButtonText != null){
       dialog.setPositiveButton(confirmButtonText, new DialogInterface.OnClickListener() {
         @Override
         public void onClick(DialogInterface dialog, int which) {
           dialog.cancel();
           result.success(true);
         }
       });
      }


      if(cancelButtonText != null){
        dialog.setNegativeButton(cancelButtonText, new DialogInterface.OnClickListener() {
          @Override
          public void onClick(DialogInterface dialog, int which) {
            dialog.cancel();
            result.success(false);
          }
        });
      }

      alertDialog = dialog.create();
      alertDialog.show();
      
    } else if(call.method.equals("hideConfirm")){
      if(alertDialog != null){
        alertDialog.dismiss();
      }
    }else if(call.method.equals("showToast")){
      String text = call.argument("text");
      int duration = call.argument("duration");
      Toast.makeText(this.activity, text, duration).show();
    }else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }

  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
    activity = binding.getActivity();
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {

  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {

  }

  @Override
  public void onDetachedFromActivity() {

  }
}
