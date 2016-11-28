//
//  OWBarChartView.h
//  OWChartView
//
//  Created by Wyman Chen on 2016/11/25.
//  Copyright © 2016年 conpak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface rectangleView : UIView

- (instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color;
- (void)startAnimating;

@end

typedef NS_ENUM(NSInteger, ChartStructureType) {
    ChartStructureType_None = 0,
    ChartStructureType_Full = 1,
    ChartStructureType_dash = 2,
};

@interface OWBarChartView : UIView

@property (nonatomic) ChartStructureType structureType;
@property (nonatomic) CGFloat structureLineWidth;
@property (nonatomic) CGFloat asixWidth;
@property (nonatomic, strong) UIFont *YAsixFont;
@property (nonatomic, strong) UIFont *XAsixFont;

- (instancetype)initWithDataDictionary:(NSDictionary *)dataDictionary;
- (instancetype)initWithFrame:(CGRect)frame DataDictionary:(NSDictionary *)dataDictionary;
- (void)showBarChartWithAnimation;

@end

/******************** dataDictionary regulation *********************/
/*
 NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
 
 NSArray *first_values = @[@(10),@(15),@(30),@(25),@(40)];
 UIColor *firstColor = [UIColor redColor];
 NSMutableDictionary *first = [NSMutableDictionary dictionary];
 [first setObject:first_values forKey:@"values"];
 [first setObject:firstColor forKey:@"color"];
 
 NSArray *second_values = @[@(0),@(20),@(25),@(40),@(60)];
 UIColor *secondColor = [UIColor yellowColor];
 NSMutableDictionary *second = [NSMutableDictionary dictionary];
 [second setObject:second_values forKey:@"values"];
 [second setObject:secondColor forKey:@"color"];
 
 NSArray *third_values = @[@(5),@(15),@(25),@(25),@(45)];
 UIColor *thirdColor = [UIColor blueColor];
 NSMutableDictionary *third = [NSMutableDictionary dictionary];
 [third setObject:third_values forKey:@"values"];
 [third setObject:thirdColor forKey:@"color"];
 
 NSArray *fourth_values = @[@(15),@(25),@(40),@(35),@(70)];
 UIColor *fourthColor = [UIColor lightGrayColor];
 NSMutableDictionary *fourth = [NSMutableDictionary dictionary];
 [fourth setObject:fourth_values forKey:@"values"];
 [fourth setObject:fourthColor forKey:@"color"];
 
 NSArray *XArray = @[@"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday"];
 NSArray *YArray = @[@(10),@(20),@(30),@(40),@(50),@(60),];
 
 [dataDic setObject:first forKey:@"first"];
 [dataDic setObject:second forKey:@"second"];
 [dataDic setObject:third forKey:@"third"];
 [dataDic setObject:fourth forKey:@"fourth"];
 [dataDic setObject:XArray forKey:@"XArray"];
 [dataDic setObject:YArray forKey:@"YArray"];
 */
