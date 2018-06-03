//
//  SubMenuController.m
//  Submenu
//
//  Created by Michael-Miao on 2018/6/3.
//  Copyright © 2018年 Michael. All rights reserved.
//

#import "SubMenuController.h"
#import <Masonry/Masonry.h>
#import "PopMenuView.h"
@interface SubMenuController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy)   NSArray * menuArray;
@property (nonatomic, strong) PopMenuView *popMenuV;

@end


static NSString *const menu_cellId = @"menu_cell";
@implementation SubMenuController

#pragma mark -- lazy data
-(NSArray *)menuArray
{
	if (!_menuArray) {
		_menuArray = [NSArray arrayWithObjects:@"A",@"B",@"C",@"D",@"E",@"F", nil];
	}
	return _menuArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self _initTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
	
}

#pragma mark -- 初始化 TableView
- (void)_initTableView
{
	UITableView *tableV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
	//tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
	tableV.rowHeight = UITableViewAutomaticDimension;
	tableV.estimatedRowHeight = 44.0f;
	tableV.dataSource = self;
	tableV.delegate = self;
	tableV.tableFooterView = [UIView new];
	[self.view addSubview:tableV];
	[tableV registerClass:[UITableViewCell class] forCellReuseIdentifier:menu_cellId];
	//[tableV registerNib:[UINib nibWithNibName:@"Shopping_Cart_Cell" bundle:nil] forCellReuseIdentifier:menu_cellId];
	
	self.tableView = tableV;
	
	UIEdgeInsets padding = UIEdgeInsetsMake(0, 0, 0, 0);
	[self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self.tableView.superview).with.insets(padding);
	}];
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.menuArray.count > 0 ? self.menuArray.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:menu_cellId forIndexPath:indexPath];
	cell.textLabel.text = self.menuArray[indexPath.row];
	return cell;
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	if (!self.popMenuV) {
		self.popMenuV = [[PopMenuView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width, 0,self.view.bounds.size.width - 60, self.view.bounds.size.height)];
		[self.view addSubview:self.popMenuV];
	}
	self.popMenuV.model = self.menuArray[indexPath.row];
	if (self.popMenuV.clickRow != indexPath.row) {
		self.popMenuV.clickRow = indexPath.row;
		if (!self.popMenuV.isShow) {
			self.popMenuV.isShow = [self.popMenuV popMenuShow];
		}
	} else {
		self.popMenuV.clickRow = -1;
		self.popMenuV.isShow = [self.popMenuV dissMenuShow];
	}
	
	__weak typeof(self) weakself = self;
	self.popMenuV.menuClickBlock = ^(id model) {
		__strong typeof(self) strongself = weakself;
		UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:strongself.menuArray[indexPath.row] message:(NSString *)model preferredStyle:UIAlertControllerStyleAlert];
		UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
			//响应事件
			//NSLog(@"action = %@", action);
		}];
		[alertVC addAction:defaultAction];
		[strongself presentViewController:alertVC animated:YES completion:nil];
	};
}

#pragma mark -- First Menu Scroll SubMenu Diss
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	if (self.popMenuV.isShow) {
		self.popMenuV.isShow = [self.popMenuV dissMenuShow];
	}
}
@end
