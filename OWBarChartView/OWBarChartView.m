//
//  OWBarChartView.m
//  OWChartView
//
//  Created by Wyman Chen on 2016/11/25.
//  Copyright © 2016年 conpak. All rights reserved.
//

#import "OWBarChartView.h"
#import "OWChartModel.h"

#define self_height self.frame.size.height
#define self_width self.frame.size.width

#define axisColor [UIColor darkGrayColor]
#define axisWidth 2.0
#define structureWidth 0.5
#define scaleLabelFont [UIFont systemFontOfSize:12.0]

@interface rectangleView()

@property (nonatomic) CGFloat rectangleHeight;
@property (nonatomic) CGFloat rectangleY;

@end

@implementation rectangleView

- (instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color
{
    self = [super initWithFrame:frame];
    if (self) {
        _rectangleHeight = frame.size.height;
        _rectangleY = self.frame.origin.y;
        
        CGRect rect = self.frame;
        rect.size.height = 0.0;
        rect.origin.y = self.frame.origin.y + _rectangleHeight;
        self.frame = rect;
        
        [self setRectangleUIWithColor:color];
    }
    return self;
}

- (void)setRectangleUIWithColor:(UIColor *)color
{
    self.backgroundColor = color;
}

- (void)startAnimating
{
    [UIView animateWithDuration:0.4 animations:^{
        CGRect rect = self.frame;
        rect.size.height = _rectangleHeight;
        rect.origin.y = _rectangleY;
        self.frame = rect;
    }];
}

@end

@interface OWBarChartView()

@property (nonatomic, strong) NSMutableArray *modelArray;
@property (nonatomic, strong) NSArray *XArray;
@property (nonatomic, strong) NSArray *YArray;
@property (nonatomic, strong) NSMutableArray *rectangleArr;
@property (nonatomic, strong) NSMutableArray *YAsixLabelArr;
@property (nonatomic, strong) NSMutableArray *XAsixLabelArr;

@end

@implementation OWBarChartView
{
    NSDictionary *dataDic;
    CGFloat averageX;
    CGFloat averageXWidth;
    CGFloat averageY;
    CGFloat rectangleWidth;
    CGFloat Proportionality;
}

#pragma mark - init methods
- (instancetype)initWithDataDictionary:(NSDictionary *)dataDictionary
{
    self = [super init];
    if (self) {
        dataDic = dataDictionary;
        [self manageData];
    }
    return self;
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    [self calculateUIParameter];
    
    [self setUI];
}

- (instancetype)initWithFrame:(CGRect)frame DataDictionary:(NSDictionary *)dataDictionary
{
    self = [super initWithFrame:frame];
    if (self) {
        dataDic = dataDictionary;
        [self manageData];
        [self calculateUIParameter];
        [self setUI];
    }
    return self;
}

#pragma mark - manageData
- (void)manageData
{
    _modelArray = [NSMutableArray array];
    
    _XArray = [NSArray arrayWithArray:dataDic[@"XArray"]];
    _YArray = [NSArray arrayWithArray:dataDic[@"YArray"]];
    
    NSArray *keyArr = [dataDic allKeys];
    for (NSString *key in keyArr) {
        if (![key isEqual:@"XArray"] && ![key isEqual:@"YArray"]) {
            NSDictionary *dic = (NSDictionary *)dataDic[key];
            OWChartModel *model = [[OWChartModel alloc] init];
            model.name = key;
            model.valueArray = dic[@"values"];
            model.modelColor = dic[@"color"];
            [_modelArray addObject:model];
        }
    }
}

#pragma mark - set UI
- (void)calculateUIParameter
{
    averageX = (self_width - 60.0)/(_XArray.count + 1);
    averageY = (self_height - 80.0)/_YArray.count;
    averageXWidth = averageX - 10.0;
    rectangleWidth = averageXWidth / _modelArray.count;
    
    Proportionality = ([_YArray[1] floatValue] - [_YArray[0] floatValue])/averageY;
}

- (void)setUI
{
    self.backgroundColor = [UIColor whiteColor];
    self.clipsToBounds = YES;
    
    [self setScaleLabel];
    
    [self setRectangles];
}

- (void)setScaleLabel
{
    _YAsixLabelArr = [NSMutableArray array];
    _XAsixLabelArr = [NSMutableArray array];
    
    //X
    for (NSInteger i = 1; i <= _XArray.count; i++) {
        if (_XArray[i - 1]) {
            UILabel *label = [[UILabel alloc] init];
            label.frame = CGRectMake(40.0 + averageX * i - averageX/2, self_height - 40.0, averageX, 20.0);
            label.font = scaleLabelFont;
            label.textColor = [UIColor darkGrayColor];
            id object = _XArray[i - 1];
            if ([object isKindOfClass:[NSNumber class]]) {
                label.text = [_XArray[i - 1] stringValue];
            } else if([object isKindOfClass:[NSString class]]) {
                label.text = _XArray[i - 1];
            }
            label.textAlignment = NSTextAlignmentCenter;
            [self addSubview:label];
            
            [_XAsixLabelArr addObject:label];
        }
    }
    
    //Y
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, self_height - 40.0 - 15.0, 35.0, 20.0);
    label.font = scaleLabelFont;
    label.textColor = [UIColor darkGrayColor];
    label.text = @"0";
    label.textAlignment = NSTextAlignmentRight;
    [self addSubview:label];
    [_YAsixLabelArr addObject:label];
    
    for (NSInteger i = 1; i <= _YArray.count; i++) {
        if (_YArray[i - 1]) {
            UILabel *label = [[UILabel alloc] init];
            label.frame = CGRectMake(0, self_height - 40.0 - averageY * i - 10.0, 35.0, 20.0);
            label.font = scaleLabelFont;
            label.textColor = [UIColor darkGrayColor];
            id object = _YArray[i - 1];
            if ([object isKindOfClass:[NSNumber class]]) {
                label.text = [_YArray[i - 1] stringValue];
            } else if([object isKindOfClass:[NSString class]]) {
                label.text = _YArray[i - 1];
            }
            label.textAlignment = NSTextAlignmentRight;
            [self addSubview:label];
            
            [_YAsixLabelArr addObject:label];
        }
    }
}

- (void)setRectangles
{
    _rectangleArr = [NSMutableArray array];
    for (NSInteger i = 0; i < _modelArray.count; i++) {
        for (NSInteger j = 1; j <= _XArray.count; j++) {
            OWChartModel *model = _modelArray[i];
            NSArray *valueArray = model.valueArray;
            CGFloat value = [valueArray[j - 1] floatValue];
            
            CGFloat x = 40.0 + averageX * j - averageXWidth/2 + i * rectangleWidth;
            CGFloat y = self_height - 40.0 - value / Proportionality;
            CGFloat width= rectangleWidth;
            CGFloat height = value / Proportionality;
            CGRect frame = CGRectMake(x, y, width, height);
            rectangleView *rectView = [[rectangleView alloc] initWithFrame:frame color:model.modelColor];
            [self addSubview:rectView];
            
            [_rectangleArr addObject:rectView];
        }
    }
}

-(void)setStructureType:(ChartStructureType)structureType
{
    _structureType = structureType;
//    [self setNeedsDisplay];
}

-(void)setStructureLineWidth:(CGFloat)structureLineWidth
{
    _structureLineWidth = structureLineWidth;
//    [self setNeedsDisplay];
}

-(void)setAsixWidth:(CGFloat)asixWidth
{
    _asixWidth = asixWidth;
}

-(void)setYAsixFont:(UIFont *)YAsixFont
{
    _YAsixFont = YAsixFont;
    for (UILabel *label in _YAsixLabelArr) {
        label.font = _YAsixFont;
    }
}

-(void)setXAsixFont:(UIFont *)XAsixFont
{
    _XAsixFont =XAsixFont;
    for (UILabel *label in _XAsixLabelArr) {
        label.font = _XAsixFont;
    }
}

#pragma mark - show bar chart
- (void)showBarChartWithAnimation
{
    for (rectangleView *rectView in _rectangleArr) {
        [rectView startAnimating];
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    //Drawing x-axis and y-axis
    UIBezierPath *axisPath = [UIBezierPath bezierPath];
    [axisPath moveToPoint:CGPointMake(40.0, 10.0)];
    [axisPath addLineToPoint:CGPointMake(40.0, self_height - 40.0)];
    [axisPath addLineToPoint:CGPointMake(self_width - 10.0, self_height - 40.0)];
    if (_asixWidth <= 0) {
        axisPath.lineWidth = axisWidth;
    } else {
        axisPath.lineWidth = _asixWidth;
    }
    UIColor *strokeColor = axisColor;
    [strokeColor set];
    [axisPath stroke];
    
    //Drawing arrows
    UIBezierPath *arrowPath1 = [UIBezierPath bezierPath];
    [arrowPath1 moveToPoint:CGPointMake(35, 15.0)];
    [arrowPath1 addLineToPoint:CGPointMake(40.0, 10.0)];
    [arrowPath1 addLineToPoint:CGPointMake(45.0, 15.0)];
    arrowPath1.lineWidth = axisWidth;
    [arrowPath1 stroke];
    
    UIBezierPath *arrowPath2 = [UIBezierPath bezierPath];
    [arrowPath2 moveToPoint:CGPointMake(self_width - 15.0, self_height - 35)];
    [arrowPath2 addLineToPoint:CGPointMake(self_width - 10.0, self_height - 40.0)];
    [arrowPath2 addLineToPoint:CGPointMake(self_width - 15.0, self_height - 45.0)];
    arrowPath2.lineWidth = axisWidth;
    [arrowPath2 stroke];
    
    for (NSInteger i = 1; i <= _YArray.count; i++) {
        UIBezierPath *yscalePath = [UIBezierPath bezierPath];
        [yscalePath moveToPoint:CGPointMake(40.0, self_height - 40.0 - averageY * i)];
        [yscalePath addLineToPoint:CGPointMake(42.0, self_height - 40.0 - averageY * i)];
        yscalePath.lineWidth = axisWidth;
        [yscalePath stroke];
        
        if (_structureType >= 1) {
            UIBezierPath *structurePath = [UIBezierPath bezierPath];
            [structurePath moveToPoint:CGPointMake(40.0, self_height - 40.0 - averageY * i)];
            [structurePath addLineToPoint:CGPointMake(self_width - 20.0, self_height - 40.0 - averageY * i)];
            if (_structureType == 2) {
                CGFloat dash[] = {1,1};
                [structurePath setLineDash:dash count:2 phase:0];
            }
            if (_structureLineWidth <= 0) {
                structurePath.lineWidth = structureWidth;
            } else {
                structurePath.lineWidth = _structureLineWidth;
            }
            UIColor *strokeColor = [UIColor lightGrayColor];
            [strokeColor set];
            [structurePath stroke];
        }
    }
    
    for (NSInteger j = 1; j <= _XArray.count; j++) {
        UIBezierPath *xscalePath = [UIBezierPath bezierPath];
        [xscalePath moveToPoint:CGPointMake(40.0 + averageX * j, self_height - 40.0)];
        [xscalePath addLineToPoint:CGPointMake(40.0 + averageX * j, self_height - 42.0)];
        xscalePath.lineWidth = axisWidth;
        [xscalePath stroke];
    }
}

@end
