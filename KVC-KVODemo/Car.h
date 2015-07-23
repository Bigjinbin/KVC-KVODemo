//
//  Car.h
//  KVC-KVODemo
//
//  Created by quiet on 15/7/23.
//  Copyright (c) 2015年 quiet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Engine.h"

@interface Car : NSObject <NSCoding>
@property (nonatomic,copy) NSString *type;
@property (nonatomic) double speed;
@property (strong,nonatomic) Engine *engine;
@end
