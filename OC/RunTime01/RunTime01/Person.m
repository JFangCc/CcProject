//
//  Person.m
//  RunTime01
//
//  Created by Able-Fangjing on 2020/12/17.
//  Copyright © 2020 Able-Fangjing. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>
//id self, SEL _cmd 隐式参数

@implementation Person
//调用没实现的类方法 会走这里
//+(BOOL)resolveClassMethod:(SEL)sel{
//
//}
//调用没实现的示例方法 会走这里
+ (BOOL)resolveInstanceMethod:(SEL)sel{
//    NSLog(@"%@",NSStringFromSelector(sel));
    //动态添加方法
    //IMP本质是函数指针
    class_addMethod(self, sel, (IMP)hhhhhhh, "v@:@");
    return [super resolveInstanceMethod:sel];
}

void hhhhhhh(id self, SEL _cmd, NSString *objc){
    NSLog(@"吃到了%@",objc);
}

@end
