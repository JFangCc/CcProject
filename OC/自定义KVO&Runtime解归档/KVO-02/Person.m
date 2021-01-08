//
//  Person.m
//  KVO-02
//
//  Created by Able-Fangjing on 2020/12/17.
//  Copyright © 2020 Able-Fangjing. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>

@implementation Person
-(void)setName:(NSString *)name{
    _name = name;
}
-(void)eat{
    NSLog(@"吃了");
}

-(void)encodeWithCoder:(NSCoder *)coder{
//    [coder encodeInt:(int)_age forKey:@"age"];
//    [coder encodeObject:_name forKey:@"name"];
    unsigned int count = 0;
    //查看一个类的所有属性列表！
    Ivar *list = class_copyIvarList(Person.class, &count);
    for (int i= 0; i < count; i++) {
        Ivar ivar = list[i];
        const char *name = ivar_getName(ivar);
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        [coder encodeObject:value forKey:key];
    }
    free(list);
}

-(instancetype)initWithCoder:(NSCoder *)coder{
    if(self = [super init]){
//        self.age = [coder decodeIntForKey:@"age"];
//        self.name = [coder decodeObjectForKey:@"name"];
        unsigned int count = 0;
        //查看一个类的所有属性列表！
        Ivar *list = class_copyIvarList(Person.class, &count);
        for (int i= 0; i < count; i++) {
            Ivar ivar = list[i];
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            id value = [coder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
        free(list);
    }
    return self;
}

@end
