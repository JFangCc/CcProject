//
//  ViewController.m
//  RunTime01
//
//  Created by Able-Fangjing on 2020/12/17.
//  Copyright © 2020 Able-Fangjing. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "NSURL+url.h"
#import <objc/message.h>

/*
 hook 钩子
 */

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //OC 方法调用 消息机制！！
    Person *p = [[Person alloc] init];
    [p performSelector:@selector(eat) withObject:@"hanbao"];
    //消息发送
    objc_msgSend(p, @selector(eat),@"hanbao");
    NSURL *url = [NSURL URLWithString:@"https://www.dsds大点的dsd.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSLog(@"%@",request);
    
}


@end
