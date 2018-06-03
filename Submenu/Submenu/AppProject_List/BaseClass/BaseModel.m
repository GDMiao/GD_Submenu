//
//  BaseModel.m
//  Submenu
//
//  Created by Michael-Miao on 2018/6/3.
//  Copyright © 2018年 Michael. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel
// 返回容器类中的所需要存放的数据类型 (以 Class 或 Class Name 的形式)。
+ (NSDictionary *)modelContainerPropertyGenericClass {
	return @{@"brands" : @"Brand"};
}

- (instancetype)init
{
	self = [super init];
	if (self) {
		
	}
	return self;
}

- (NSString *)jsonStr
{
	return @"";
}
@end
