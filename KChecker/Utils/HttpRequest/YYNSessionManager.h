//
//  YYNSessionManager.h
//  yiyuan_OA
//
//  Created by Liao Qiang on 2018/4/20.
//  Copyright © 2018 Liao Qiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
//#import "HttpRequest.h"

//网络请求成功，回掉的块
typedef void (^success)(id ret);
//网络请求错误
typedef void (^failure)(id error);

@interface YYNSessionManager : AFHTTPSessionManager

//timeout时间
@property (nonatomic,assign)int timeOutTime;

- (void)method:(NSString *)method URLString:(NSString *)urlStr andParams:(NSDictionary *)params andHttpHeaders:(NSDictionary *)headers success:(success)success failure:(failure)failure;

- (void)uploadWithURLString:(NSString *)urlStr andParams:(NSDictionary *)params andHeaders:(NSDictionary *)headers andFiles:(NSArray *)pathArray andFileNames:(NSArray *)fileNames success:(success)success failure:(failure)failure;

+ (YYNSessionManager *)defaultSessionManager;

@end
