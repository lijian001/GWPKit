//
//  GWPShowBadgeViewController.m
//  GWPKitDEMO
//
//  Created by GanWenPeng on 16/2/2.
//  Copyright © 2016年 GanWenPeng. All rights reserved.
//

#import "GWPShowBadgeViewController.h"
#import "GWPKit.h"
#import "ReactiveCocoa.h"

@interface GWPShowBadgeViewController ()<UITabBarDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation GWPShowBadgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setup];
    
}

- (void)setup {
    self.title = @"Badge";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"off"] style:UIBarButtonItemStyleDone target:self action:@selector(cancelClick)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"action-1"] style:UIBarButtonItemStyleDone target:self action:@selector(actionClick)];
    [self.navigationItem.rightBarButtonItem showBadgeForRect:CGRectMake(5, 5, 5, 5) color:[UIColor redColor]];
    
    
    UIButton *btn = [[UIButton alloc] init];
    btn.backgroundColor = [UIColor orangeColor];
    [btn setTitle:@"button1" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(100, 100, 100, 40);
    
    [btn showBadgeForRect:CGRectMake(-5, -5, 10, 10) color:[UIColor redColor]];
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [btn clearBadge];
    }];
    
    UITabBar *bar = [[UITabBar alloc] init];
    bar.delegate = self;
    UITabBarItem *one = [[UITabBarItem alloc] initWithTitle:@"one" image:[UIImage imageNamed:@"home"] tag:0];
    bar.items = @[
                  one,
                  [[UITabBarItem alloc] initWithTitle:@"two" image:[UIImage imageNamed:@"home"] tag:1],
                  [[UITabBarItem alloc] initWithTitle:@"three" image:[UIImage imageNamed:@"home"] tag:2],
                  [[UITabBarItem alloc] initWithTitle:@"four" image:[UIImage imageNamed:@"home"] tag:3]
                  ];
    [self.view addSubview:bar];
    bar.selectedItem = one;
    bar.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[bar]-20-|" options:0 metrics:nil views:@{@"bar" : bar}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[bar(49)]-20-|" options:0 metrics:nil views:@{@"bar" : bar}]];
    [self tabBar:bar didSelectItem:one];
    
    self.imageView.image = [UIImage imageNamed:@"icon"];
    self.imageView.userInteractionEnabled = YES;
    [self.imageView showBadgeForRect:CGRectMake(5, 5, 5, 5) color:[UIColor redColor]];
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconClick)]];
}

- (void)iconClick{
    [self.imageView clearBadge];
}

- (void)actionClick{
    [self.navigationItem.rightBarButtonItem clearBadge];
}

- (void)cancelClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITabBarDelegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
    for (UITabBarItem *item in tabBar.items) {
        [item clearBadge];
    }
    
    
    [item showBadgeForRect:CGRectMake(10, 10, 5, 5) color:[UIColor redColor]];
}
@end
