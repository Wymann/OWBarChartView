//
//  OWBarChartModel.h
//  OWChartView
//
//  Created by Wyman Chen on 2016/11/25.
//  Copyright © 2016年 conpak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OWChartModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray *valueArray;
@property (nonatomic, strong) UIColor *modelColor;

@end
