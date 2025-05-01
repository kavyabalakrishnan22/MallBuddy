import Flutter
import UIKit

import flutter_local_notifications

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

//   flutterLocalNotificationsPlugin.setPluginREgistrantCallback {(registry) in
//   GeneratedPluginRegistrant.register(with:registry)}

    GeneratedPluginRegistrant.register(with: self)

//     if #available(iOS 10.0,*){
//      UNUserNotificationsCenter.current().delegate = self as? UNUserNotificationCenterDelegate
//      }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
