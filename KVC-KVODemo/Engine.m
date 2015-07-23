//
//  Engine.m
//  KVC-KVODemo
//
//  Created by quiet on 15/7/23.
//  Copyright (c) 2015年 quiet. All rights reserved.
//

#import "Engine.h"

@implementation Engine
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeDouble:self.power forKey:@"power"];
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super init])
    {
        self.power = [aDecoder decodeDoubleForKey:@"speed"];
    }
    return self;
}
@end
