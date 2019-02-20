//
//  MyMD5.m
//  GoodLectures
//
//  Created by yangshangqing on 11-10-11.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "MyMD5.h"
#import "CommonCrypto/CommonDigest.h"


@implementation MyMD5

+(NSString *) md5: (NSString *) inPutText  uppercaseString:(BOOL)isUppercase
{
    if (inPutText == nil) {
        return nil;
    }
    const char *cStr = [inPutText UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (uint32_t)strlen(cStr), result);
    
    NSString *afterMd5 = [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                          result[0], result[1], result[2], result[3],
                          result[4], result[5], result[6], result[7],
                          result[8], result[9], result[10], result[11],
                          result[12], result[13], result[14], result[15]
                          ];
    if (isUppercase) {
        return [afterMd5 uppercaseString];
    }
    else
    {
        return [afterMd5 lowercaseString];
    }
}

+(NSString *) md5: (NSString *) inPutText
{
    return [self md5:inPutText uppercaseString:NO];
}
@end
