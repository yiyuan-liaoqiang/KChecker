//
//  PushUtils.m
//  KChecker
//
//  Created by LiaoQiang on 2019/4/20.
//

#import "PushUtils.h"
#import <CloudPushSDK/CloudPushSDK.h>
#import "KChecker-Swift.h"

@implementation PushUtils
static PushUtils *_util;

+ (PushUtils *)shared {
    if (_util == nil) {
        _util = PushUtils.new;
        [_util initCloudPush];
        [_util registerMessageReceive];
    }
    return _util;
}

- (void)initCloudPush {
    // SDK初始化
    [CloudPushSDK asyncInit:@"26009078" appSecret:@"2c78762847c2e962195d39a6bfa8b871" callback:^(CloudPushCallbackResult *res) {
        if (res.success) {
            NSLog(@"Push SDK init success, deviceId: %@.", [CloudPushSDK getDeviceId]);
        } else {
            NSLog(@"Push SDK init failed, error: %@", res.error);
        }
    }];
}

- (void)registerAPNS:(UIApplication *)application {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        // iOS 8 Notifications
        [application registerUserNotificationSettings:
         [UIUserNotificationSettings settingsForTypes:
          (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge)
                                           categories:nil]];
        [application registerForRemoteNotifications];
    }
    else {
        // iOS < 8 Notifications
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
    }
}

/*
 *  苹果推送注册成功回调，将苹果返回的deviceToken上传到CloudPush服务器
 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [CloudPushSDK registerDevice:deviceToken withCallback:^(CloudPushCallbackResult *res) {
        if (res.success) {
            NSLog(@"Register deviceToken success.");
        } else {
            NSLog(@"Register deviceToken failed, error: %@", res.error);
        }
    }];
}
/*
 *  苹果推送注册失败回调
 */
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"didFailToRegisterForRemoteNotificationsWithError %@", error);
}

/**
 *    注册推送消息到来监听
 */
- (void)registerMessageReceive {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onMessageReceived:)
                                                 name:@"CCPDidReceiveMessageNotification"
                                               object:nil];
}
/**
 *    处理到来推送消息
 */
- (void)onMessageReceived:(NSNotification *)notification {
    CCPSysMessage *message = [notification object];
    NSString *title = [[NSString alloc] initWithData:message.title encoding:NSUTF8StringEncoding];
    NSString *body = [[NSString alloc] initWithData:message.body encoding:NSUTF8StringEncoding];
    NSLog(@"Receive message title: %@, content: %@.", title, body);
    NSDictionary *dic = [self JSONStringToDictionaryWithData:body];
    NSString *sql = [NSString stringWithFormat:@"replace into facility(id,style,facilityId,planTime,state,planId,standardId,standard,versionType,partName,transactorId,facilityName,componentName) values ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",dic[@"id"],dic[@"style"],dic[@"facilityId"],dic[@"planTime"],dic[@"state"],dic[@"planId"],dic[@"standardId"],dic[@"standard"],dic[@"versionType"],dic[@"partName"],dic[@"transactorId"],dic[@"facilityName"],dic[@"componentName"]];
    [DBUtil.sharedUtil update:sql];
    NSLog(@"%@",dic);
}

-(NSDictionary *) JSONStringToDictionaryWithData:(NSString *)data{
    NSError * error;
    NSData * m_data = [data  dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dict = [NSJSONSerialization  JSONObjectWithData:m_data options:NSJSONReadingMutableContainers error:&error];
    return dict;
}

/*
 *  App处于启动状态时，通知打开回调
 */
- (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)userInfo {
    NSLog(@"Receive one notification.");
    // 取得APNS通知内容
    NSDictionary *aps = [userInfo valueForKey:@"aps"];
    // 内容
    NSString *content = [aps valueForKey:@"alert"];
    // badge数量
    NSInteger badge = [[aps valueForKey:@"badge"] integerValue];
    // 播放声音
    NSString *sound = [aps valueForKey:@"sound"];
    // 取得Extras字段内容
    NSString *Extras = [userInfo valueForKey:@"Extras"]; //服务端中Extras字段，key是自己定义的
    NSLog(@"content = [%@], badge = [%ld], sound = [%@], Extras = [%@]", content, (long)badge, sound, Extras);
    // iOS badge 清0
    application.applicationIconBadgeNumber = 0;
    // 通知打开回执上报
    // [CloudPushSDK handleReceiveRemoteNotification:userInfo];(Deprecated from v1.8.1)
    NSLog(@"userInfo = %@",userInfo);
    [CloudPushSDK sendNotificationAck:userInfo];
}
@end
