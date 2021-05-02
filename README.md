# flutter_native_alert

💨🚀 flutter_native_alert offers the ability to display Android and iOS native dialog and toast

## Get started

### Add dependency

```yaml
dependencies:
  flutter_native_alert: ^1.2.1
```

### Usage and screenshots

#####  Native Dialog for Android and iOS
```dart
/// If ret is true, click OK, if false, click cancel
bool ret = await FlutterNativeAlert.getInstance().showConfirm(
  title: "Welcome to use",
  message: "flutter_native_alert offers the ability to display Android and iOS native dialog and toast",
  confirmButtonText: "OK",  /// Optional, the text of the confirmation button, null means that the button is not displayed
  cancelButtonText: "Cancel", /// Optional, the text of the cancel button, null means that the button is not displayed
);

/// If you need to close the Dialog in the code
FlutterNativeAlert.getInstance().hideConfirm();
```
<img src="https://raw.githubusercontent.com/fengerwoo/flutter_native_alert/main/doc/assets/android_dialog.png" width="300"/> <img src="https://raw.githubusercontent.com/fengerwoo/flutter_native_alert/main/doc/assets/ios_dialog.png" width="340"/>
<br/><br/>

#####  Native Toast for Android and iOS
```dart
/// Pass in the string to be displayed, the default display time is 1.5 seconds
FlutterNativeAlert.getInstance().showToast("I'm a Toast", duration: Duration(milliseconds: 1500));
```
<img src="https://raw.githubusercontent.com/fengerwoo/flutter_native_alert/main/doc/assets/android_toast.png" width="300"/> <img src="https://raw.githubusercontent.com/fengerwoo/flutter_native_alert/main/doc/assets/ios_toast.png" width="340"/>
<br/><br/>