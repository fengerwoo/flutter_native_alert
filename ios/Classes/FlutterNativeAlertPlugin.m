#import "FlutterNativeAlertPlugin.h"
#import <WHToast/WHToast.h>

@implementation FlutterNativeAlertPlugin

{
    @public UIAlertController *alert;
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_native_alert"
            binaryMessenger:[registrar messenger]];
  FlutterNativeAlertPlugin* instance = [[FlutterNativeAlertPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  FlutterAppDelegate* delegate = (FlutterAppDelegate*)[[UIApplication sharedApplication]delegate];
  FlutterViewController* rootVC = (FlutterViewController*)delegate.window.rootViewController;
    
  if ([@"showConfirm" isEqualToString:call.method]) {
    NSString *title = call.arguments[@"title"];
    NSString *message = call.arguments[@"message"];
    NSString *confirmButtonText = call.arguments[@"confirmButtonText"];
    NSString *cancelButtonText = call.arguments[@"cancelButtonText"];
    
    alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
      
    if(confirmButtonText != NULL){
      [alert addAction:[UIAlertAction actionWithTitle:confirmButtonText style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
            result([NSNumber numberWithBool:true]);
          }
       ]];
    }
      
    if(cancelButtonText != NULL){
        [alert addAction:[UIAlertAction actionWithTitle:cancelButtonText style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
              result([NSNumber numberWithBool:false]);
            }
         ]];
    }
      
    [rootVC presentViewController:alert animated:true completion:nil];
      
  }else if([@"hideConfirm" isEqualToString:call.method]){
      if(alert != nil){
        [alert dismissViewControllerAnimated:true completion:nil];
      }
  }else if([@"showToast" isEqualToString:call.method]){
      NSString *text = call.arguments[@"text"];
      NSNumber *duration = call.arguments[@"duration"];
      CGFloat customY = rootVC.view.bounds.size.height - 200;
      [WHToast setShowMask:NO];
      [WHToast showMessage:text originY: customY duration:([duration doubleValue]/1000) finishHandler:^{}];
  }else {
      result(FlutterMethodNotImplemented);
  }
}

@end
