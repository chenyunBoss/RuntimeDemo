//
//  Person.h
//  RuntimeDemo
//
//  Created by chenyun on 2018/2/24.
//  Copyright © 2018年 yctc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject <NSCopying, NSCoding>

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *age;

@end
