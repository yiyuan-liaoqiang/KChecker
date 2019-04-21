//
//  PushUtils.h
//  KChecker
//
//  Created by LiaoQiang on 2019/4/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PushUtils : NSObject

+ (PushUtils *)shared;

/**
 *    注册苹果推送，获取deviceToken用于推送
 *
 */
- (void)registerAPNS:(UIApplication *)application;

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;

- (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)userInfo;

@end

NS_ASSUME_NONNULL_END
