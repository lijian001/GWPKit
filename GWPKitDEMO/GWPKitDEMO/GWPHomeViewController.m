//
//  GWPHomeViewController.m
//  GWPKitDEMO
//
//  Created by GanWenPeng on 16/1/30.
//  Copyright © 2016年 GanWenPeng. All rights reserved.
//

#import "GWPHomeViewController.h"
#import "GWPCenterViewController.h"
#import "GWPLeftViewController.h"
#import "GWPRightViewController.h"
#import "GWPGIFViewController.h"
#import "GWPDisplayViewController.h"
#import "ReactiveCocoa.h"

@interface GWPHomeViewController ()
@property (nonatomic, strong) NSArray<GWPBaseCellModel *> *cellModels;
@end

@implementation GWPHomeViewController
#pragma mark - 懒加载
- (NSArray<GWPBaseCellModel *> *)cellModels{
    if (!_cellModels) {
        __weak typeof(self) weakSelf = self;
        GWPBaseCellModel *slider1 = [GWPBaseCellModel modelWithImage:nil title:@"SliderViewController - SliderType1" subTitle:nil targetClass:nil clickHandler:^{
            UINavigationController *center = [[UINavigationController alloc] initWithRootViewController:[[GWPCenterViewController alloc] init]];
            GWPSliderController *vc = [GWPSliderController sliderControllerWithCenterVc:center leftVc:[[GWPLeftViewController alloc] init] rightVc:[[GWPRightViewController alloc] init] type:SliderType1];
            [center.viewControllers lastObject].title = @"SliderViewController - SliderType1";
            vc.showLeftWhenCenterSwipeToRight = YES;
            vc.showRightWhenCenterSwipeToLeft = YES;
            [GWPCommonTool sharedGWPCommonTool].sliderVc = vc;
            [weakSelf presentViewController:vc animated:YES completion:nil];
        }];
        GWPBaseCellModel *slider2 = [GWPBaseCellModel modelWithImage:nil title:@"SliderViewController - SliderType2" subTitle:nil targetClass:nil clickHandler:^{
            
            UINavigationController *center = [[UINavigationController alloc] initWithRootViewController:[[GWPCenterViewController alloc] init]];
            GWPSliderController *vc = [GWPSliderController sliderControllerWithCenterVc:center leftVc:[[GWPLeftViewController alloc] init] rightVc:[[GWPRightViewController alloc] init] type:SliderType2];
            [center.viewControllers lastObject].title = @"SliderViewController - SliderType2";
            vc.showLeftWhenCenterSwipeToRight = YES;
            vc.showRightWhenCenterSwipeToLeft = YES;
            [GWPCommonTool sharedGWPCommonTool].sliderVc = vc;
            [weakSelf presentViewController:vc animated:YES completion:nil];
        }];
        GWPBaseCellModel *gif = [GWPBaseCellModel modelWithImage:nil title:@"Loading GIF Image - GWPGIFView" subTitle:nil targetClass:nil clickHandler:^{
            GWPGIFViewController *gif = [[GWPGIFViewController alloc] init];
            gif.title = @"Loading GIF Image - GWPGIFView";
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:gif];
            [weakSelf presentViewController:nav animated:YES completion:nil];
        }];
        GWPBaseCellModel *badge = [GWPBaseCellModel modelWithImage:nil title:@"Badge" subTitle:nil targetClass:nil clickHandler:nil];
        GWPBaseCellModel *tabbar = [GWPBaseCellModel modelWithImage:nil title:@"Tab with underline" subTitle:nil targetClass:nil clickHandler:^{
            GWPDisplayViewController *vc = [[GWPDisplayViewController alloc] init];
            vc.view.backgroundColor = [UIColor whiteColor];
            vc.title = @"Tab with underline";
            GWPUnderlineSegmentedControl *seg = [[GWPUnderlineSegmentedControl alloc] initWithItems:@[@"one", @"two", @"three", @"four"]];
            [vc.view addSubview:seg];
            seg.selectedSegmentIndex = 0;
            [seg setUnderlineColor:[UIColor redColor] forState:UIControlStateSelected];
            [seg setUnderlineColor:[UIColor redColor] forState:UIControlStateHighlighted];
            [seg setUnderlineColor:[UIColor grayColor] forState:UIControlStateNormal];
            
            [seg setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [seg setBackgroundColor:[UIColor blueColor] forState:UIControlStateSelected];
            
            [seg setTitleTextAttributes:@{
                                          NSForegroundColorAttributeName : [UIColor blackColor]
                                          } forState:UIControlStateNormal];
            [seg setTitleTextAttributes:@{
                                          NSForegroundColorAttributeName : [UIColor whiteColor]
                                          } forState:UIControlStateSelected];

            seg.size = CGSizeMake(300, 44);
            seg.centerX = vc.view.centerX;
            seg.y = 200;
            [weakSelf presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:nil];
        }];
        GWPBaseCellModel *nohightBtn = [GWPBaseCellModel modelWithImage:nil title:@"Have no highlight state button" subTitle:nil targetClass:nil clickHandler:^{
            GWPDisplayViewController *vc = [[GWPDisplayViewController alloc] init];
            vc.view.backgroundColor = [UIColor whiteColor];
            GWPNoHighlightButton *btn = [[GWPNoHighlightButton alloc] init];
            btn.backgroundColor = [UIColor orangeColor];

            [btn setTitle:@"No Highlight Button" forState:UIControlStateNormal];
            [vc.view addSubview:btn];
            btn.translatesAutoresizingMaskIntoConstraints = NO;
            [vc.view addConstraints:@[
                                            [NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:vc.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0],
                                            [NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:vc.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:-100]
                                            ]];
            [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                [MBProgressHUD showMessage:btn.currentTitle];
            }];
            vc.title = @"Have no highlight state button";
            [weakSelf presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:nil];
        }];
        GWPBaseCellModel *rightIconBtn = [GWPBaseCellModel modelWithImage:nil title:@"Display image on the right of button" subTitle:nil targetClass:nil clickHandler:^{
            GWPDisplayViewController *vc = [[GWPDisplayViewController alloc] init];
            vc.view.backgroundColor = [UIColor whiteColor];
            GWPRightImageButton *btn = [[GWPRightImageButton alloc] init];
            btn.backgroundColor = [UIColor orangeColor];
            
            [btn setTitle:@"Right Image Button" forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"icon"] forState:UIControlStateNormal];
            
            [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                [MBProgressHUD showMessage:btn.currentTitle];
            }];

            
            [vc.view addSubview:btn];
            btn.translatesAutoresizingMaskIntoConstraints = NO;
            [vc.view addConstraints:@[
                                      [NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:vc.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0],
                                      [NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:vc.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:-100]
                                      ]];
            vc.title = @"Display image at right of button";
            [weakSelf presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:nil];
        }];
        _cellModels = @[slider1, slider2, gif, badge, tabbar, nohightBtn, rightIconBtn];
    }
    return _cellModels;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

- (void)setup {
    self.title = @"GWPKit DEMO";
    
}


#pragma mark - UITableViewDataSource、Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cellModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *const identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    GWPBaseCellModel *model = self.cellModels[indexPath.row];
    cell.textLabel.text = model.title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GWPBaseCellModel *model = self.cellModels[indexPath.row];
    if (model.clickHandler) {
        model.clickHandler();
        return;
    }
}
@end
