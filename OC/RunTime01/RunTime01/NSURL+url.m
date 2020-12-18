//
//  NSURL+url.m
//  RunTime01
//
//  Created by Able-Fangjing on 2020/12/17.
//  Copyright © 2020 Able-Fangjing. All rights reserved.
//

#import "NSURL+url.h"
#import <objc/runtime.h>

@implementation NSURL (url)

+(void)load{
    Method urlWithStr = class_getClassMethod(self, @selector(URLWithString:));
    Method FJ_urlWithStr = class_getClassMethod(self, @selector(FJ_URLWithString:));
    method_exchangeImplementations(urlWithStr, FJ_urlWithStr);
}

+(instancetype)FJ_URLWithString:(NSString *)URLString{
    NSURL *url = [self FJ_URLWithString:URLString];
    if(URLString == nil){
        NSLog(@"url 空了");
    }
    return url;
}

@end
