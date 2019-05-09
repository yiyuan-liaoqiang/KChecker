//
//  AppDelegate.swift
//  ZhaoPin
//
//  Created by LiaoQiang on 2019/1/23.
//  Copyright © 2019年 Liao Qiang. All rights reserved.
//

import UIKit
import CloudPushSDK
import SwiftyJSON
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    var nav:UINavigationController!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        if AccountHelper.isLogin {
            self.nav = UINavigationController(rootViewController: MainViewController())
            self.nav.toolbar.isHidden = true
            
            //推送
            PushUtils.shared().registerAPNS(application)
            //绑定账号到阿里云推送
            let info = (try? YYNCache.userRelatedStorage?.object(forKey: "userInfo").dictionary)
            if let userInfo = info as? [String:Any] {
                let userId = userInfo["userId"] as? JSON
                CloudPushSDK.bindAccount((userId?.stringValue)!) { (res) in }
            }
            else {
                AccountHelper.userInfo([:]) { (err, obj) in }
            }
        }
        else {
            self.nav = UINavigationController(rootViewController: LoginViewController())
            self.nav.toolbar.isHidden = true
        }
        print(CloudPushSDK.isChannelOpened())
        self.window?.rootViewController = self.nav
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        ResendRequest().resendRequest()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        PushUtils.shared().application(application, didReceiveRemoteNotification: userInfo)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // 通知弹出，且带有声音、内容和角标（App处于前台时不建议弹出通知）
        completionHandler(UNNotificationPresentationOptions(rawValue: UNNotificationPresentationOptions.sound.rawValue | UNNotificationPresentationOptions.badge.rawValue | UNNotificationPresentationOptions.alert.rawValue));
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        PushUtils.shared().application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    }
}

