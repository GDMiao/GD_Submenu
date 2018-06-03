//
//  PopMenuView.m
//  Submenu
//
//  Created by Michael-Miao on 2018/6/3.
//  Copyright © 2018年 Michael. All rights reserved.
//

#import "PopMenuView.h"
static NSString *const submenu_cellId = @"submenu_cell";
@implementation PopMenuView

#pragma mark -- lazy data
- (NSArray *)submenuArray
{
	if (!_submenuArray) {
		_submenuArray = [NSArray arrayWithObjects:@"A1",@"B1",@"C1",@"D1",@"E1",@"F1",@"G1",@"H1",@"I1",@"J1", nil];
	}
	return _submenuArray;
}

- (void)setModel:(id)model
{
	_model = model;
	[self.tableView reloadData];
}

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		_isShow = NO;
		_clickRow = -1;
		_originFrame = frame;
		_newFrame = CGRectMake(60, 0, frame.size.width, frame.size.height);
		[self _initTableView];
	}
	return self;
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
	[self addSubview:tableV];
	[tableV registerClass:[UITableViewCell class] forCellReuseIdentifier:submenu_cellId];
	//[tableV registerNib:[UINib nibWithNibName:@"Shopping_Cart_Cell" bundle:nil] forCellReuseIdentifier:menu_cellId];
	
	self.tableView = tableV;
	
	UIEdgeInsets padding = UIEdgeInsetsMake(0, 0, 0, 0);
	[self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self.tableView.superview).with.insets(padding);
	}];
	
	UISwipeGestureRecognizer * recognizer;
	recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
	[recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
	[self.tableView addGestureRecognizer:recognizer];
	
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.submenuArray.count > 0 ? self.submenuArray.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:submenu_cellId forIndexPath:indexPath];
	cell.textLabel.text = [NSString stringWithFormat:@"%@-%@",self.model,self.submenuArray[indexPath.row]];
	return cell;
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSLog(@"click Cell - %@" ,[NSString stringWithFormat:@"%@-%@",self.model,self.submenuArray[indexPath.row]]);
	self.menuClickBlock([NSString stringWithFormat:@"%@-%@",self.model,self.submenuArray[indexPath.row]]);
}


#pragma mark -- Show and Diss
- (BOOL)popMenuShow
{
	[UIView animateWithDuration:0.5 animations:^{
		self.frame = self.newFrame;
	}];
	return  YES;
}

- (BOOL)dissMenuShow
{
	[UIView animateWithDuration:0.5 animations:^{
		self.frame = self.originFrame;
	}];
	self.clickRow = -1;
	return NO;
}

#pragma mark -- 滑动手势事件
- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
	if(recognizer.direction == UISwipeGestureRecognizerDirectionDown) {
		NSLog(@"swipe down");
	}
	if(recognizer.direction == UISwipeGestureRecognizerDirectionUp) {
		NSLog(@"swipe up");
	}
	if(recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
		NSLog(@"swipe left");
	}
	if(recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
		NSLog(@"swipe right");
		self.isShow = [self dissMenuShow];
		
	}
}

@end
