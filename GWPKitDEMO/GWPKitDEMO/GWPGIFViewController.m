//
//  GWPGIFViewController.m
//  GWPKitDEMO
//
//  Created by GanWenPeng on 16/1/31.
//  Copyright © 2016年 GanWenPeng. All rights reserved.
//

#import "GWPGIFViewController.h"

@interface GWPGIFViewController ()

@end

@implementation GWPGIFViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    GWPGIFView *gif = [[GWPGIFView alloc] initWithFrame:CGRectMake(0, 0, 240, 240) filePath:[[NSBundle mainBundle] pathForResource:@"reSubmit" ofType:@"gif"]];
    [self.view addSubview:gif];
    gif.size = CGSizeMake(240, 240);
    gif.center = self.view.center;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"off"] style:UIBarButtonItemStyleDone target:self action:@selector(cancelClick)];
}

- (void)cancelClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
