//
//  ViewController.m
//  Submenu
//
//  Created by Michael-Miao on 2018/6/1.
//  Copyright © 2018年 Michael. All rights reserved.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>
@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy)   NSArray * menuArray;
@property (nonatomic, copy)   NSArray * submenuArray;
@end

static NSString *const menu_cellId = @"menu_cell";
@implementation ViewController
#pragma mark -- lazy data
-(NSArray *)menuArray
{
	if (!_menuArray) {
		_menuArray = [NSArray arrayWithObjects:@"A",@"B",@"C",@"D",@"E",@"F", nil];
	}
	return _menuArray;
}
- (NSArray *)submenuArray
{
	if (!_submenuArray) {
		_submenuArray = [NSArray arrayWithObjects:@"A1",@"B1",@"C1",@"D1",@"E1",@"F1",@"G1",@"H1",@"I1",@"J1", nil];
	}
	return _submenuArray;
}
- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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
	tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
	tableV.rowHeight = UITableViewAutomaticDimension;
	tableV.estimatedRowHeight = 44.0f;
	tableV.dataSource = self;
	tableV.delegate = self;
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
	
}
@end
