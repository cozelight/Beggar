//
//  GZOAuthTool.m
//  Beggar
//
//  Created by Madao on 15/8/3.
//  Copyright (c) 2015年 GanZhen. All rights reserved.
//

#import "GZOAuthTool.h"

#include <CommonCrypto/CommonDigest.h>
#include <CommonCrypto/CommonHMAC.h>

typedef void (^AFServiceProviderRequestHandlerBlock)(NSURLRequest *request);
typedef void (^AFServiceProviderRequestCompletionBlock)();

NSString * const kAFOAuthConsumerKey = @"628995bdd46948e469a34742c88210fe";
NSString * const kAFOAuthConsumerSecret = @"1f61c472c6f51d3c02bd98e21b804e79";
NSString * const kAFOAuth1Version = @"1.0";NSString * const NSStringFromAFOAuthSignatureMethod = @"HMAC-SHA1";


static inline NSString * AFNounce() {
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
    
    return (NSString *)CFBridgingRelease(string);
}


@implementation GZOAuthTool

+ (NSDictionary *)OAuthParameters {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"oauth_version"] = kAFOAuth1Version;
    parameters[@"oauth_signature_method"] = NSStringFromAFOAuthSignatureMethod;
    parameters[@"oauth_timestamp"] = [@(floor([[NSDate date] timeIntervalSince1970])) stringValue];
    parameters[@"oauth_nonce"] = AFNounce();
    parameters[@"oauth_consumer_key"] = kAFOAuthConsumerKey;
    parameters[@"oauth_signature"] = [GZOAuthTool HmacSha1:kAFOAuthConsumerKey data:kAFOAuthConsumerSecret];
    
    return parameters;
}

+ (NSString *)HmacSha1:(NSString *)key data:(NSString *)data
{
    const char *cKey  = [key cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cData = [data cStringUsingEncoding:NSASCIIStringEncoding];
    //Sha256:
    // unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    //CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    //sha1
    unsigned char cHMAC[CC_SHA1_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC
                                          length:sizeof(cHMAC)];
    
    NSString *hash = [HMAC base64EncodedStringWithOptions:0];//将加密结果进行一次BASE64编码。
    return hash;
}

@end
