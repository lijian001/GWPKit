//
//  GWPCommonTool.h
//  GWPKitDEMO
//
//  Created by GanWenPeng on 16/1/31.
//  Copyright © 2016年 GanWenPeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GWPKit.h"

@class GWPSliderController;

@interface GWPCommonTool : NSObject
singleton_interface(GWPCommonTool)

@property (nonatomic, strong) GWPSliderController *sliderVc;
@end
