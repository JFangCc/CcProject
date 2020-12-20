//
//  Person.h
//  KVO-02
//
//  Created by Able-Fangjing on 2020/12/17.
//  Copyright © 2020 Able-Fangjing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject<NSCoding>
@property(nonatomic,strong)NSString *name;
@property(nonatomic,assign)NSInteger age;
@property(nonatomic,strong)NSString *name1;
@property(nonatomic,strong)NSString *name2;
@property(nonatomic,strong)NSString *name3;
@end

NS_ASSUME_NONNULL_END
