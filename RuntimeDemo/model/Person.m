//
//  Person.m
//  RuntimeDemo
//
//  Created by chenyun on 2018/2/24.
//  Copyright © 2018年 yctc. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>

@implementation Person

- (id)copyWithZone:(NSZone *)zone {
    Person *model = [[[self class] allocWithZone:zone] init];
    for (NSString *property in [model getAllProperties]) {
        [model setValue:[[self valueForKeyPath:property] copyWithZone:zone] forKey:property];
    }
    
    return model;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    for (NSString *property in [self getAllProperties]) {
        [aCoder encodeObject:[self valueForKey:property] forKey:property];
    }
    //    [aCoder encodeObject:self.realName forKey:@"realName"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        for (NSString *property in [self getAllProperties]) {
            [self setValue:[aDecoder decodeObjectForKey:property] forKey:property];
        }
        //        self.realName = [aDecoder decodeObjectForKey:@"realName"];
    }
    return self;
}

- (NSDictionary *)transFromModelToDictionary {
    
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (NSInteger i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *char_f = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        if (propertyValue) {
            [props setObject:propertyValue forKey:propertyName];
        }
    }
    free(properties);
    return props;
}

/// 获取类的所有属性
- (NSArray *)getAllProperties {
    //    u_int count;
    //    // 动态获取属性
    //    objc_property_t *properties = class_copyPropertyList([self class], &count);
    //
    //    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    //
    //    for (NSInteger i = 0; i < count; i++) {
    //        const char *propertyName = property_getName(properties[i]);
    //
    //        [propertiesArray addObject:[NSString stringWithUTF8String:propertyName]];
    //    }
    //    return propertiesArray;
    NSMutableArray *perperies = [NSMutableArray array];
    
    unsigned int outCount;
    //动态获取属性
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    
    //遍历person类的所有属性
    for (int i = 0; i < outCount; i++)
    {
        objc_property_t property = properties[i];
        const char *name = property_getName(property);
        
        NSString *s = [[NSString alloc] initWithUTF8String:name];
        
        [perperies addObject:s];
        
    }
    
    return perperies;
    
}

@end
