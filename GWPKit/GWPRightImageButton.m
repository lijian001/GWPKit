//
//  GWPRightImageButton.m
//  GWPKitDEMO
//
//  Created by GanWenPeng on 16/2/1.
//  Copyright © 2016年 GanWenPeng. All rights reserved.
//

#import "GWPRightImageButton.h"

@implementation GWPRightImageButton
- (void)layoutSubviews{
    [super layoutSubviews];
    
    // 重新布局文字和图片的位置
    self.titleLabel.x = 0;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame);
    if (self.isSizeToFit) {
        // 按钮尺寸自适应
        [self sizeToFit];
    }
    
}

- (void)setIsSizeToFit:(BOOL)isSizeToFit{
    _isSizeToFit = isSizeToFit;
    [self sizeToFit];
    [self layoutSubviews];
}
@end
