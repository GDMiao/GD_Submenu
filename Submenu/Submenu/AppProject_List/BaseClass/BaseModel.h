//
//  BaseModel.h
//  Submenu
//
//  Created by Michael-Miao on 2018/6/3.
//  Copyright © 2018年 Michael. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel/YYModel.h>
#import "Brand.h"
@interface BaseModel : NSObject
@property (nonatomic, strong) NSString * brandCssPath;
@property (nonatomic, strong) NSArray * brands;
@property (nonatomic, strong) NSString * seriesCssPath;
@property (nonatomic, strong) NSString * version;
@property (nonatomic, strong) NSString * versionBrand;
@end
