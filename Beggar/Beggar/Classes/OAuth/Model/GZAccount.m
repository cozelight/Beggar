//
//  GZAccount.m
//  Beggar
//
//  Created by Madao on 15/8/4.
//  Copyright (c) 2015年 GanZhen. All rights reserved.
//

#import "GZAccount.h"
#import "MJExtension.h"

@implementation GZAccount

+ (instancetype)accountWithDict:(AFOAuth1Token *)access_token
{
    GZAccount *account = [[GZAccount alloc] init];
    
    account.key = access_token.key;
    account.secret = access_token.secret;
    account.session = access_token.session;
    return account;
}

//- (id)initWithCoder:(NSCoder *)decoder
//{
//    if (self = [super init]) {
//        self.key = [decoder decodeObjectForKey:@"key"];
//        self.secret = [decoder decodeObjectForKey:@"secret"];
//        self.session = [decoder decodeObjectForKey:@"session"];
//    }
//    return self;
//}
//
//- (void)encodeWithCoder:(NSCoder *)encoder
//{
//    [encoder encodeObject:self.key forKey:@"key"];
//    [encoder encodeObject:self.secret forKey:@"secret"];
//    [encoder encodeObject:self.session forKey:@"session"];
//}

MJCodingImplementation

@end
