//
//  ViewController.m
//  KVO-02
//
//  Created by Able-Fangjing on 2020/12/17.
//  Copyright © 2020 Able-Fangjing. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+FJKVO.h"
#import <objc/message.h>
#import "Person.h"

@interface ViewController ()
@property(nonatomic,strong)Person *p;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.p = [[Person alloc] init];
//    self.p = objc_msgSend(Person.class, @selector(alloc));
    
//    self.p = objc_msgSend(NSClassFromString(@("Person")), NSSelectorFromString(@"alloc"));
    
//    self.p = objc_msgSend(objc_getClass("Person"), NSSelectorFromString(@"alloc"));
    
    self.p = objc_msgSend(objc_getClass("Person"), sel_registerName("alloc"));
    
    self.p = objc_msgSend(self.p, @selector(init));
    objc_msgSend(self.p, @selector(eat));
    //添加观察者
    
    //内部实现：利用runtime 动态创建一个Person的子类
    //修改p对象的指针（isa）指向的类型！！指向子类类型NSKVONOtfing_Person
    [self.p FJ_addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
}
- (IBAction)save:(id)sender {
    Person *p = [[Person alloc] init];
    p.name = @"fangjing";
    p.age = 18;
    
    NSString *tempPath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"fang"];
    [NSKeyedArchiver archiveRootObject:p toFile:tempPath];
}

- (IBAction)get:(id)sender {
    NSString *tempPath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"fang"];
    Person *p = [NSKeyedUnarchiver unarchiveObjectWithFile:tempPath];
    NSLog(@"%li%@",p.age,p.name);
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"%@",change[@"new"]);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    static int a;
    self.p.name = [NSString stringWithFormat:@"%d",a++];
}

- (void)dealloc{
    [self.p removeObserver:self forKeyPath:@"name"];
}

@end
