//
//  OWShowChartVC.h
//  OWChartView
//
//  Created by Wyman Chen on 2016/11/25.
//  Copyright © 2016年 conpak. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, OWShowChartType) {
    OWShowChartType_line = 0,
    OWShowChartType_bar = 1,
    OWShowChartType_pie = 2,
};

@interface OWShowChartVC : UIViewController

- (instancetype)initWithShowChartType:(OWShowChartType)chartType;

@end
