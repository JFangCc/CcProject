//
//  NSObject+FJKVO.m
//  KVO-02
//
//  Created by Able-Fangjing on 2020/12/17.
//  Copyright © 2020 Able-Fangjing. All rights reserved.
//

#import "NSObject+FJKVO.h"
#import <objc/message.h>

@implementation NSObject (FJKVO)
//自定义KVO
- (void)FJ_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context{
    NSString *oldName = NSStringFromClass(self.class);
    NSString *newName = [@"FJKVO_" stringByAppendingString:oldName];
    //新建一个子类
    Class newClass = objc_allocateClassPair(self.class, newName.UTF8String, 0);
    //注册子类
    objc_registerClassPair(newClass);
    object_setClass(self, newClass);
    
    class_addMethod(newClass, @selector(setName:), (IMP)setName, "");
}

void setName(id self, SEL _cmd, NSString *newName) {
    [self willChangeValueForKey:@"name"];
    NSLog(@"拿到了%@",newName);
    [self didChangeValueForKey:@"name"];
}

@end
