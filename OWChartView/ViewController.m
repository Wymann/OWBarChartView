//
//  ViewController.m
//  OWChartView
//
//  Created by Wyman Chen on 2016/11/25.
//  Copyright © 2016年 conpak. All rights reserved.
//

#import "ViewController.h"
#import "OWShowChartVC.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, strong) NSArray *titlesArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initArray];
    
    [self setMyTableView];
}

- (void)initArray
{
    _titlesArray = @[@"线形图表(Line Chart)", @"柱状图表(Bar Chart)", @"饼状图表(Pie Chart)"];
}

- (void)setMyTableView
{
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.textLabel.text = _titlesArray[indexPath.row];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    OWShowChartVC *showChartVC;
    if (indexPath.row == 0) {
        showChartVC = [[OWShowChartVC alloc] initWithShowChartType:OWShowChartType_line];
    } else if (indexPath.row == 1) {
        showChartVC = [[OWShowChartVC alloc] initWithShowChartType:OWShowChartType_bar];
    } else {
        showChartVC = [[OWShowChartVC alloc] initWithShowChartType:OWShowChartType_pie];
    }
    [self presentViewController:showChartVC animated:YES completion:nil];
}

@end
