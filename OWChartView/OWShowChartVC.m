//
//  OWShowChartVC.m
//  OWChartView
//
//  Created by Wyman Chen on 2016/11/25.
//  Copyright © 2016年 conpak. All rights reserved.
//

#import "OWShowChartVC.h"
#import "OWBarChartView.h"

#define height self.view.frame.size.height
#define width self.view.frame.size.width

@interface OWShowChartVC ()

@property (nonatomic, strong) OWBarChartView *barChart;

@end

@implementation OWShowChartVC
{
    OWShowChartType showChartType;
}

- (instancetype)initWithShowChartType:(OWShowChartType)chartType
{
    self = [super init];
    if (self) {
        showChartType = chartType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setUI];
}

#pragma mark - set UI
- (void)setUI
{
    [self setTitleLabel];
    
    [self setBackButton];
    
    [self setRefreshButton];
    
    [self setChartView];
}

- (void)setTitleLabel
{
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake((width - 150.0)/2, 30.0, 150.0, 21.0);
    [self.view addSubview:titleLabel];
    titleLabel.font = [UIFont systemFontOfSize:16.0];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    if (showChartType == OWShowChartType_line) {
        titleLabel.text = @"Line Chart";
    } else if (showChartType == OWShowChartType_bar) {
        titleLabel.text = @"Bar Chart";
    } else {
        titleLabel.text = @"Pie Chart";
    }
}

- (void)setBackButton
{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(15.0, height - 50.0, 50.0, 30.0);
    [self.view addSubview:backBtn];
    [backBtn setTitle:@"Back" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setRefreshButton
{
    UIButton *refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    refreshBtn.frame = CGRectMake(width - 90.0, height - 50.0, 70.0, 30.0);
    [self.view addSubview:refreshBtn];
    [refreshBtn setTitle:@"showBar" forState:UIControlStateNormal];
    [refreshBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [refreshBtn addTarget:self action:@selector(showBar) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setChartView
{
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    
    NSArray *first_values = @[@(20),@(15),@(30),@(25),@(40)];
    UIColor *firstColor = [UIColor redColor];
    NSMutableDictionary *first = [NSMutableDictionary dictionary];
    [first setObject:first_values forKey:@"values"];
    [first setObject:firstColor forKey:@"color"];
    
    NSArray *second_values = @[@(10),@(30),@(25),@(40),@(60)];
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
    
    NSArray *XArray = @[@"Mon", @"Tue", @"Wed", @"Thur", @"Fri"];
    NSArray *YArray = @[@(5),@(10),@(15),@(20),@(25),@(30),@(35),@(40),@(45),@(50),@(55),@(60),];
    [dataDic setObject:first forKey:@"first"];
    [dataDic setObject:second forKey:@"second"];
//    [dataDic setObject:third forKey:@"third"];
//    [dataDic setObject:fourth forKey:@"fourth"];
    [dataDic setObject:XArray forKey:@"XArray"];
    [dataDic setObject:YArray forKey:@"YArray"];
    if (showChartType == OWShowChartType_line) {
        
    } else if (showChartType == OWShowChartType_bar) {
        _barChart = [[OWBarChartView alloc] initWithDataDictionary:dataDic];
        CGFloat chartHeight = 300.0;
        _barChart.frame = CGRectMake(0, (height - chartHeight)/2, width, chartHeight);
        _barChart.structureType = ChartStructureType_Full;
        _barChart.structureLineWidth = 0.5;
        _barChart.asixWidth = 2.0;
        _barChart.XAsixFont = [UIFont systemFontOfSize:12.0];
        _barChart.YAsixFont = [UIFont systemFontOfSize:12.0];
        [self.view addSubview:_barChart];
    } else {
        
    }
}

#pragma mark - button click
- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)showBar
{
    if (_barChart) {
        [_barChart showBarChartWithAnimation];
    }
}

@end
