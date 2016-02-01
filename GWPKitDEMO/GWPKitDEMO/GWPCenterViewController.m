//
//  GWPCenterViewController.m
//  GWPKitDEMO
//
//  Created by GanWenPeng on 16/1/30.
//  Copyright © 2016年 GanWenPeng. All rights reserved.
//

#import "GWPCenterViewController.h"

@interface GWPCenterViewController ()
- (IBAction)showLeftClick;
- (IBAction)showRightClick;

@end

@implementation GWPCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    
}

- (void)setup {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"off"] style:UIBarButtonItemStyleDone target:self action:@selector(cancelClick)];
    
}

- (void)cancelClick{
    [[GWPCommonTool sharedGWPCommonTool].sliderVc dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)showLeftClick {
    [[GWPCommonTool sharedGWPCommonTool].sliderVc showLeft];
}

- (IBAction)showRightClick {
    [[GWPCommonTool sharedGWPCommonTool].sliderVc showRight];
}
@end
