//
//  Car.m
//  KVC-KVODemo
//
//  Created by quiet on 15/7/23.
//  Copyright (c) 2015年 quiet. All rights reserved.
//

#import "Car.h"

@implementation Car
//重写父类的方法, 父类的方法默认当key抛出异常, 重写之后不做任何操作
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
//为什么加?
//加了这两个方法, 就可归档和解档当前对象
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.type forKey:@"type"];
    [aCoder encodeDouble:self.speed forKey:@"speed"];
    [aCoder encodeObject:self.engine forKey:@"engine"];
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super init])
    {
        self.type = [aDecoder decodeObjectForKey:@"type"];
        self.speed = [aDecoder decodeDoubleForKey:@"speed"];
        self.engine = [aDecoder decodeObjectForKey:@"engine"];
    }
    return self;
}
@end
