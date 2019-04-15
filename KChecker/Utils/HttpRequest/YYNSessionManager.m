//
//  YYNSessionManager.m
//  yiyuan_OA
//
//  Created by Liao Qiang on 2018/4/20.
//  Copyright © 2018 Liao Qiang. All rights reserved.
//

#import "YYNSessionManager.h"
#import "KChecker-Swift.h"

@implementation YYNSessionManager

- (void)method:(NSString *)method URLString:(NSString *)urlStr andParams:(NSDictionary *)params andHttpHeaders:(NSDictionary *)headers success:(success)success failure:(failure)failure
{
    params = [self handleParams:params andUrlStr:urlStr];
    if(self.timeOutTime == 0)
        self.requestSerializer.timeoutInterval = 25;
    else
    {
        self.requestSerializer.timeoutInterval = self.timeOutTime;
        self.timeOutTime = 0;
    }
    
    if ([method.lowercaseString isEqualToString:@"post"]) {
        [self requestWithURLString:urlStr andParams:params andHttpHeaders:headers success:success failure:failure];
    }
    else if ([method.lowercaseString isEqualToString:@"get"])
    {
        [self getRequestWithURLString:urlStr andParams:params andHeaders:headers success:success failure:failure];
    }
    else if ([method.lowercaseString isEqualToString:@"put"])
    {
        [self putRequestWithUrlString:urlStr andParams:params andHeaders:headers success:success failure:failure];
    }
    else if ([method.lowercaseString isEqualToString:@"delete"])
    {
        [self deleteRequestWithUrlString:urlStr andParams:params andHeaders:headers success:success failure:failure];
    }
}

- (void)requestWithURLString:(NSString *)urlStr andParams:(NSDictionary *)params andHttpHeaders:(NSDictionary *)headers success:(success)success failure:(failure)failure
{
    NSString *completelyUrlStr = [self handleUrlString:urlStr];
    if (![urlStr isEqualToString:@"im-session-list"]) {
        NSLog(@"url --> %@ params --> %@",completelyUrlStr,params);
    }
    
    [self headerOperations:headers];
    
    [self POST:completelyUrlStr parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleSuccessRespond:responseObject andTask:task];
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleErrorFailureBlock:failure andError:error andUrlString:urlStr];
    }];
}

- (void)getRequestWithURLString:(NSString *)urlStr andParams:(NSDictionary *)params andHeaders:(NSDictionary *)headers success:(success)success failure:(failure)failure
{
    [self headerOperations:headers];
    NSString *completelyUrlStr = [self handleUrlString:urlStr];

    NSLog(@"url --> %@ params --> %@",completelyUrlStr,params);
    
    [self GET:completelyUrlStr parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleSuccessRespond:responseObject andTask:task];
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleErrorFailureBlock:failure andError:error andUrlString:urlStr];
    }];
}

- (void)putRequestWithUrlString:(NSString *)urlStr andParams:(NSDictionary *)params andHeaders:(NSDictionary *)headers success:(success)success failure:(failure)failure
{
    [self headerOperations:headers];
    NSString *completelyUrlStr = [self handleUrlString:urlStr];
    NSLog(@"url --> %@ params --> %@",completelyUrlStr,params);
    
    [self PUT:completelyUrlStr parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleSuccessRespond:responseObject andTask:task];
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleErrorFailureBlock:failure andError:error andUrlString:urlStr];
    }];
}

- (void)deleteRequestWithUrlString:(NSString *)urlStr andParams:(NSDictionary *)params andHeaders:(NSDictionary *)headers success:(success)success failure:(failure)failure
{
    [self headerOperations:headers];
    NSString *completelyUrlStr = [self handleUrlString:urlStr];
    NSLog(@"url --> %@ params --> %@",completelyUrlStr,params);
    
    [self DELETE:completelyUrlStr parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleSuccessRespond:responseObject andTask:task];
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleErrorFailureBlock:failure andError:error andUrlString:urlStr];
    }];
}

- (void)headerOperations:(NSDictionary *)headers
{
    if (headers) {
        NSArray *keys = [headers allKeys];
        for (NSString *key in keys) {
            NSString *value = [NSString stringWithFormat:@"%@",headers[key]];
            [self.requestSerializer setValue:value forHTTPHeaderField:key];
        }
    }
    NSString *token = [AccountHelper token];
    if (token != nil && token.length > 0) {
        [self.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    }
    [self.requestSerializer setValue:@"ios" forHTTPHeaderField:@"platform"];
}

- (void)uploadWithURLString:(NSString *)urlStr andParams:(NSDictionary *)params andHeaders:(NSDictionary *)headers andFiles:(NSArray *)pathArray andFileNames:(NSArray *)fileNames success:(success)success failure:(failure)failure
{
    NSString *completelyUrlStr = [self handleUrlString:urlStr];
    [self headerOperations:headers];

    self.requestSerializer.timeoutInterval = 20;
    [self POST:completelyUrlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (NSInteger i = 0; i<pathArray.count; i++) {
            NSString *filePath = [pathArray objectAtIndex:i];
            if ([filePath isKindOfClass:NSURL.class]) {
                filePath = ((NSURL *)filePath).path;
            }
            NSData *data = [NSData dataWithContentsOfFile:filePath];
            if (fileNames.count) {
                [formData appendPartWithFileData:data name:fileNames.firstObject fileName:[filePath componentsSeparatedByString:@"/"].lastObject mimeType:@"image/png"];
            }
            else
            {
                [formData appendPartWithFileData:data name:@"file" fileName:[[filePath componentsSeparatedByString:@"/"] lastObject] mimeType:@"image/png"];
            }
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"%@",uploadProgress.localizedDescription);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleSuccessRespond:responseObject andTask:task];
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        if (response.statusCode == 200) {
            success(nil);
        }
        else
        {
            failure(error.description);
        }
        [self handleErrorFailureBlock:failure andError:error andUrlString:urlStr];
    }];
}

- (void)handleSuccessRespond:(id)respond andTask:(NSURLSessionTask *)task
{
    if ([respond isKindOfClass:NSDictionary.class]) {
        NSInteger code = [[respond objectForKey:@"code"] integerValue];
        if (code != 0 && code != 200) {
            NSLog(@"code  ============ %ld,url ============ %@,error = %@",code,task.currentRequest.URL.absoluteString,[respond objectForKey:@"message"]);
        }
    }
}

- (void)handleErrorFailureBlock:(failure)failure andError:(NSError *)error andUrlString:(NSString *)urlString
{
    NSLog(@"url--%@",urlString);
    NSLog(@"%@",error);
    if (failure) {
        failure(error.description);
    }
    if (error.code == 401) {
        //未登录
#ifdef TARGET_OA
        [CommonUtils provideUserLogin];
#endif
        
    }
}

/**
 处理接口地址，如果是完整地址，则不需要再次拼接
 */
- (NSString *)handleUrlString:(NSString *)urlStr
{
    NSString *completelyUrlStr = urlStr;
    if(![urlStr hasPrefix:@"http"])
    {
        completelyUrlStr = [NSString stringWithFormat:@"%@%@",YYNDOMAIN,urlStr];
    }
    return completelyUrlStr;
}

+ (YYNSessionManager *)defaultSessionManager
{
    YYNSessionManager *httpManager = [[YYNSessionManager alloc] init];
    //请求头
    httpManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    httpManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/json",@"application/json", @"text/javascript",@"text/plain",@"image/jpeg",@"image/png", @"text/xml",nil];
    return httpManager;
}

- (NSDictionary *)handleParams:(NSDictionary *)params andUrlStr:(NSString *)url
{
    if ([params isKindOfClass:NSDictionary.class]) {
        NSMutableDictionary *mdic = [params mutableCopy];
        //去掉单纯的/参数
        [mdic setObject:@"ios" forKey:@"platform"];
        return mdic.copy;
    }
    return params;
}
@end
