//
//  BrandsList.h
//  Submenu
//
//  Created by Michael-Miao on 2018/6/3.
//  Copyright © 2018年 Michael. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Brand : NSObject
/*
 "firstchar": "B",
 "updatetime": "2017-11-18 15:47:28",
 "status": 0,
 "autoid": "16329",
 "cid": "00AU0BRd0PeJ",
 "name": "B--北汽威旺"
 */
@property (nonatomic, copy) NSString *firstchar;
@property (nonatomic, copy) NSString *updatetime;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *autoid;
@property (nonatomic, copy) NSString *cid;
@property (nonatomic, copy) NSString *name;
@end
