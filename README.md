# OWBarChartView

show chartview with animation.

HOW TO USE:

step one:
    pod 'OWBarChartView', '~> 0.0.1'
    or
    download Demo.

step two:
  Create a NSDictionary as data, the format of the dictionary is as follows:
  
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
    
    NSArray *XArray = @[@"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday"];
    NSArray *YArray = @[@(5),@(10),@(15),@(20),@(25),@(30),@(35),@(40),@(45),@(50),@(55),@(60),];
    [dataDic setObject:first forKey:@"first"];
    [dataDic setObject:second forKey:@"second"];
    [dataDic setObject:XArray forKey:@"XArray"];
    [dataDic setObject:YArray forKey:@"YArray"];
    
    (Comment: "XArray", "YArray" are necessary.)
    
step three:
    Create a OWBarChartView.
    
    _barChart = [[OWBarChartView alloc] initWithDataDictionary:dataDic];
        CGFloat chartHeight = 300.0;
        _barChart.frame = CGRectMake(0, (height - chartHeight)/2, width, chartHeight);
        _barChart.structureType = ChartStructureType_Full;
        _barChart.structureLineWidth = 0.5;
        _barChart.asixWidth = 2.0;
        _barChart.XAsixFont = [UIFont systemFontOfSize:12.0];
        _barChart.YAsixFont = [UIFont systemFontOfSize:12.0];
        [self.view addSubview:_barChart];
        
If you still dont understand, please check the code in the Demo. If you find anything wrong, feel free to correct me.
---By a rookie.
