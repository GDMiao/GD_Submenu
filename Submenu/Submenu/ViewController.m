//
//  ViewController.m
//  Submenu
//
//  Created by Michael-Miao on 2018/6/1.
//  Copyright © 2018年 Michael. All rights reserved.
//

#import "ViewController.h"
#import "SubMenuController.h"
@interface ViewController ()
@property (nonatomic, strong) SubMenuController *submenuVC;
@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	SubMenuController *subMenuVC = [[SubMenuController alloc] init];
	[self addChildViewController:subMenuVC];
	//不添加 frame 默认 submenuVC 的大小同父类控制器大小
	//subMenuVC.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
	subMenuVC.view.backgroundColor = [UIColor cyanColor];
	[self.view addSubview:subMenuVC.view];
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
