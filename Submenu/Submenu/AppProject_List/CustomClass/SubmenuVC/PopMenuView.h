//
//  PopMenuView.h
//  Submenu
//
//  Created by Michael-Miao on 2018/6/3.
//  Copyright © 2018年 Michael. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

@interface PopMenuView : UIView<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, copy) void(^menuClickBlock)(id model);
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy)   NSArray * submenuArray;
@property (nonatomic, strong) id model;
@property (nonatomic) BOOL isShow;
@property (nonatomic) CGRect originFrame;
@property (nonatomic) CGRect newFrame;
@property (nonatomic, assign) NSInteger clickRow;
- (BOOL)popMenuShow;
- (BOOL)dissMenuShow;
@end
