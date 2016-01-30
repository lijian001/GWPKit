//
//  GWPHomeViewController.m
//  GWPKitDEMO
//
//  Created by GanWenPeng on 16/1/30.
//  Copyright © 2016年 GanWenPeng. All rights reserved.
//

#import "GWPHomeViewController.h"
#import "GWPKit.h"

@interface GWPHomeViewController ()
@property (nonatomic, strong) NSArray<GWPBaseCellModel *> *cellModels;
@end

@implementation GWPHomeViewController
#pragma mark - 懒加载
- (NSArray<GWPBaseCellModel *> *)cellModels{
    if (!_cellModels) {
        GWPBaseCellModel *slider1 = [GWPBaseCellModel modelWithImage:nil title:@"抽屉-SliderType1" subTitle:nil targetClass:nil clickHandler:nil];
        GWPBaseCellModel *slider2 = [GWPBaseCellModel modelWithImage:nil title:@"抽屉-SliderType2" subTitle:nil targetClass:nil clickHandler:nil];
        GWPBaseCellModel *gif = [GWPBaseCellModel modelWithImage:nil title:@"加载GIF-GWPGIFView" subTitle:nil targetClass:nil clickHandler:nil];
        GWPBaseCellModel *badge = [GWPBaseCellModel modelWithImage:nil title:@"小红点" subTitle:nil targetClass:nil clickHandler:nil];
        GWPBaseCellModel *tabbar = [GWPBaseCellModel modelWithImage:nil title:@"带下划线的选项卡" subTitle:nil targetClass:nil clickHandler:nil];
        GWPBaseCellModel *nohightBtn = [GWPBaseCellModel modelWithImage:nil title:@"禁止高亮状态的按钮" subTitle:nil targetClass:nil clickHandler:nil];
        GWPBaseCellModel *rightIconBtn = [GWPBaseCellModel modelWithImage:nil title:@"图片显示在右侧的图片" subTitle:nil targetClass:nil clickHandler:nil];
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
@end
