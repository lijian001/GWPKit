//
//  GWPSliderController.m
//  GWPExtension
//
//  Created by GWP on 15/7/7.
//  Copyright (c) 2015年 GanWenPeng. All rights reserved.
//

#import "GWPSliderController.h"
#import "PureLayout.h"
#import "UIView+GWPKit.h"

static CGFloat const timeLength = 0.3;

@interface GWPSliderController ()<NSURLSessionDelegate>
/** 左侧栏宽度约束 */
@property (nonatomic, weak) NSLayoutConstraint *leftWidthC;

/** 右侧栏宽度约束 */
@property (nonatomic, weak) NSLayoutConstraint *rightWidthC;

@end

@implementation GWPSliderController
#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
}



+ (instancetype)sliderControllerWithCenterVc:(UIViewController *)centerVc leftVc:(UIViewController *)leftVc rightVc:(UIViewController *)rightVc type:(SliderType)type{
    NSAssert(centerVc, @"使用 %@ 时，centerVc不得为空",[centerVc class]);
    
    GWPSliderController *sliderVc = [[GWPSliderController alloc] init];
    sliderVc.type = type;
    NSMutableDictionary *views = [NSMutableDictionary dictionary];
    views[@"center"] = centerVc.view;
    if (leftVc)     views[@"left"] = leftVc.view;
    if (rightVc)    views[@"right"] = rightVc.view;
    
    if (type==SliderType1) {
        sliderVc.centerVc = centerVc;
        [sliderVc addChildViewController:centerVc];
        [sliderVc.view addSubview:centerVc.view];
        centerVc.view.translatesAutoresizingMaskIntoConstraints = NO;
        
//        [centerVc.view autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
        [centerVc.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[centerV]-0-|" options:0 metrics:nil views:views]];
        
        
        if (leftVc) {
            sliderVc.leftVc = leftVc;
            [sliderVc addChildViewController:leftVc];
            [sliderVc.view addSubview:leftVc.view];
            [leftVc.view autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeRight];
            sliderVc.leftWidthC = [leftVc.view autoSetDimension:ALDimensionWidth toSize:(sliderVc.leftWidth ? sliderVc.leftWidth : 100)];
            leftVc.view.hidden = YES;
        }
        
        if (rightVc) {
            sliderVc.rightVc = rightVc;
            [sliderVc addChildViewController:rightVc];
            [sliderVc.view addSubview:rightVc.view];
            [rightVc.view autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeLeft];
            sliderVc.rightWidthC = [rightVc.view autoSetDimension:ALDimensionWidth toSize:(sliderVc.rightWidth ? sliderVc.rightWidth : 100)];
            rightVc.view.hidden = YES;
        }
    } else if (type==SliderType2) {
        
        if (leftVc) {
            sliderVc.leftVc = leftVc;
            [sliderVc addChildViewController:leftVc];
            [sliderVc.view addSubview:leftVc.view];
            [leftVc.view autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeRight];
            sliderVc.leftWidthC = [leftVc.view autoSetDimension:ALDimensionWidth toSize:(sliderVc.leftWidth ? sliderVc.leftWidth : 100)];
            leftVc.view.hidden = YES;
        }
        
        if (rightVc) {
            sliderVc.rightVc = rightVc;
            [sliderVc addChildViewController:rightVc];
            [sliderVc.view addSubview:rightVc.view];
            [rightVc.view autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeLeft];
            sliderVc.rightWidthC = [rightVc.view autoSetDimension:ALDimensionWidth toSize:(sliderVc.rightWidth ? sliderVc.rightWidth : 100)];
            rightVc.view.hidden = YES;
        }
        
        sliderVc.centerVc = centerVc;
        [sliderVc addChildViewController:centerVc];
        [sliderVc.view addSubview:centerVc.view];
        [centerVc.view autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
        
    }
    
    
    
    
    // 蒙版
    UIButton *cover = [[UIButton alloc] init];
    cover.hidden = YES;
    cover.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    [cover addTarget:sliderVc action:@selector(resetEveryView) forControlEvents:UIControlEventTouchUpInside];
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:sliderVc action:@selector(resetEveryView)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [cover addGestureRecognizer:recognizer];
    [centerVc.view addSubview:cover];
    [cover autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    
    sliderVc.cover = cover;
    
    return sliderVc;
}

- (void)setResetWhenLeftViewSwipeToLeft:(BOOL)resetWhenLeftViewSwipeToLeft{
    _resetWhenLeftViewSwipeToLeft = resetWhenLeftViewSwipeToLeft;
    if (self.leftVc) {
        UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(resetEveryView)];
        swipe.direction = UISwipeGestureRecognizerDirectionLeft;
        [self.leftVc.view addGestureRecognizer:swipe];
    };
}


- (void)setResetWhenRightViewSwipeToRight:(BOOL)resetWhenRightViewSwipeToRight{
    _resetWhenRightViewSwipeToRight = resetWhenRightViewSwipeToRight;
    if (self.rightVc) {
        UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(resetEveryView)];
        swipe.direction = UISwipeGestureRecognizerDirectionRight;
        [self.rightVc.view addGestureRecognizer:swipe];
    }
}


- (void)setShowLeftWhenCenterSwipeToRight:(BOOL)showLeftWhenCenterSwipeToRight{
    _showLeftWhenCenterSwipeToRight = showLeftWhenCenterSwipeToRight;
    if (self.leftVc) {
        UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(showLeft)];
        swipe.direction = UISwipeGestureRecognizerDirectionRight;
        [self.centerVc.view addGestureRecognizer:swipe];
    }
}

- (void)setShowRightWhenCenterSwipeToLeft:(BOOL)showRightWhenCenterSwipeToLeft{
    if (self.rightVc) {
        UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(showRight)];
        swipe.direction = UISwipeGestureRecognizerDirectionLeft;
        [self.centerVc.view addGestureRecognizer:swipe];
    }
}

- (void)setLeftWidth:(CGFloat)leftWidth{
    _leftWidth = leftWidth;
    self.leftWidthC.constant = leftWidth;
}

- (void)setRightWidth:(CGFloat)rightWidth{
    _rightWidth = rightWidth;
    self.rightWidthC.constant = rightWidth;
}

- (void)showLeft{
    if (_is_leftShow){
        [self resetEveryView];
        return;
    }
    
    _is_leftShow = YES;
    
    _leftVc.view.hidden = NO;
    self.cover.alpha = 0;
    self.cover.hidden = NO;
    __weak typeof(self) weakSelf = self;
    
    if (_type==SliderType1) {
        _leftVc.view.x = -self.leftWidthC.constant;
        [UIView animateWithDuration:(_transformTime ? _transformTime : timeLength) animations:^{
            weakSelf.leftVc.view.x = 0;
            weakSelf.cover.alpha = 0.2;
        } completion:^(BOOL finished) {
        }];
    } else if (_type==SliderType2) {
        [UIView animateWithDuration:(_transformTime ? _transformTime : timeLength) animations:^{
            weakSelf.centerVc.view.x = weakSelf.leftWidthC.constant;
            weakSelf.cover.alpha = 0.2;
        } completion:^(BOOL finished) {
            weakSelf.is_leftShow = YES;
        }];
    }
    
    
}

- (void)showRight{
    if (_is_rightShow){
        [self resetEveryView];
        return;
    }
    
    _is_rightShow = YES;
    
    _rightVc.view.hidden = NO;
    self.cover.alpha = 0;
    self.cover.hidden = NO;
    
    __weak typeof(self) weakSelf = self;
    
    if (_type==SliderType1) {
        _rightVc.view.x = -_rightWidthC.constant;
        [UIView animateWithDuration:(_transformTime ? _transformTime : timeLength) animations:^{
            weakSelf.rightVc.view.x = 0;
            weakSelf.cover.alpha = 0.2;
        } completion:^(BOOL finished) {
        }];
    } else if (_type==SliderType2) {
        [UIView animateWithDuration:(_transformTime ? _transformTime : timeLength) animations:^{
            weakSelf.centerVc.view.x = -weakSelf.rightWidthC.constant;
            weakSelf.cover.alpha = 0.2;
        } completion:^(BOOL finished) {
            weakSelf.is_rightShow = YES;
        }];
    }
    
    
}

- (void)resetEveryView{
    __weak typeof(self) weakSelf = self;
    _is_leftShow = NO;
    _is_rightShow = NO;
    
    if (_type==SliderType1) {
        [UIView animateWithDuration:(_transformTime ? _transformTime : timeLength) animations:^{
            weakSelf.leftVc.view.x = -weakSelf.leftWidthC.constant;
            weakSelf.rightVc.view.x = -weakSelf.rightWidthC.constant;
            weakSelf.cover.alpha = 0;
        } completion:^(BOOL finished) {
            weakSelf.is_rightShow = NO;
            weakSelf.is_leftShow = NO;
            
            _leftVc.view.hidden = YES;
            _rightVc.view.hidden = YES;
            weakSelf.cover.hidden = YES;
        }];
    } else if (_type==SliderType2){
        [UIView animateWithDuration:(_transformTime ? _transformTime : timeLength) animations:^{
            weakSelf.centerVc.view.x = 0;
            weakSelf.cover.alpha = 0;
        } completion:^(BOOL finished) {
            weakSelf.is_rightShow = NO;
            weakSelf.is_leftShow = NO;
            
            _leftVc.view.hidden = YES;
            _rightVc.view.hidden = YES;
            weakSelf.cover.hidden = YES;
        }];
    }
    
}
@end
