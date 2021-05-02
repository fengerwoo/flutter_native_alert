import 'dart:async';

import 'package:flutter/services.dart';


/// Flutter 提示弹窗
/// Created by 枫儿 on 2021/5/2.
/// @email：hsnndly@163.com
class FlutterNativeAlert{


  static FlutterNativeAlert _flutterNativeAlert;
  static FlutterNativeAlert getInstance() {
    if (_flutterNativeAlert == null) {
      _flutterNativeAlert = FlutterNativeAlert();
    }
    return _flutterNativeAlert;
  }


  MethodChannel _channel = MethodChannel("flutter_native_alert");


  /// @Desc  : 显示 Android|iOS 原生确认弹框
  /// [title] 弹框头部文字
  /// [message] 弹框消息文字
  /// [confirmButtonText] 确认按钮文字，如果传 null 为不显示该按钮
  /// [cancelButtonText] 取消按钮文字，如果传 null 为不显示该按钮
  /// 返回true为点击确认键，false为返回键
  /// @author: 枫儿
  Future<bool> showConfirm({
    String title = "title",
    String message = "message",
    String confirmButtonText = "OK",
    String cancelButtonText = "Cancel",
  }) async{
    return await _channel.invokeMethod("showConfirm", {"title": title, "message": message, "confirmButtonText": confirmButtonText, "cancelButtonText": cancelButtonText, });
  }


  /// @Desc  : 隐藏调用showConfirm当前显示的 Android|iOS 原生确认弹框
  /// @author: 枫儿
  void hideConfirm() async{
    await _channel.invokeMethod("hideConfirm", {});
  }


  /// @Desc  : 显示 Android|iOS 原生吐司
  /// [text] 吐司要显示的文字
  /// [duration] 显示时长，默认1.5秒
  /// @author: 枫儿
  void showToast(
    String text  ,{
    Duration duration = const Duration(milliseconds: 1500),
  }) async {
    await _channel.invokeMethod("showToast", {"text": text, "duration": duration.inMilliseconds,});
  }

}