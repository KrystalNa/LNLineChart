//
//  LNLineChartView.m
//  pianoteiphone
//
//  Created by Doris on 2017/3/31.
//  Copyright © 2017年 阎. All rights reserved.
//

#import "LNLineChartView.h"
#import "BEMSimpleLineGraphView.h"

#define MAXPAGEPOINTCOUNT 6
#define HOLDPAGECOUNT 3

@interface LNLineChartView()<BEMSimpleLineGraphDelegate, BEMSimpleLineGraphDataSource,UIScrollViewDelegate>
{
    CGFloat star3Y;
    CGFloat star2Y;
    CGFloat star1Y;
    CGFloat yWidth;
    CGFloat xHeight;
    
    UIScrollView *graphScrollView;
    BEMSimpleLineGraphView *myGraph;
    
    NSInteger curPage;
    
    NSInteger totalPages;
    
    UIView *myGraphXAxis;
    
    CGFloat CHART_X;
    
    UIImageView *noDatsTipsView;
}
@property (nonatomic,strong) NSMutableArray *starValueArr;
@property (nonatomic,strong) NSArray *starTempValueArr;
@property (nonatomic, strong) NSDateFormatter *formatter;
@property (nonatomic, strong) NSDateFormatter *minuteFormatter;
@property (nonatomic, strong) NSDateFormatter *monthFormatter;
@end

@implementation LNLineChartView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        CHART_X = 20*MLPercent;
        xHeight = 55*MLPercent;
        [self createYSubview];
        [self createChartScrollView];
        
    }
    return self;
}

- (void)createYSubview{

    UILabel *yLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    yLabel.text = @"成绩";
    yLabel.font = [UIFont systemFontOfSize:16*MLPercent];
    yLabel.textColor = MLGrayColor(115);
    [yLabel sizeToFit];
    [self addSubview:yLabel];
    
    
    
    UILabel *starLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, yLabel.bottom+18*MLPercent, 0, 0)];
    starLabel1.text = @"3";
    starLabel1.font = [UIFont systemFontOfSize:22*MLPercent];
    starLabel1.textColor = MLColor(255, 154, 26);
    [starLabel1 sizeToFit];
    [self addSubview:starLabel1];
    
    CGFloat space = (self.height-xHeight-yLabel.height-4*starLabel1.height)/5;
    starLabel1.y = yLabel.bottom+space;
    
    UIImageView *star1 = [[UIImageView alloc] initWithFrame:CGRectMake(starLabel1.right+5*MLPercent, starLabel1.y, 19*MLPercent, 19*MLPercent)];
    star1.centerY = starLabel1.centerY;
    star1.image = createImage(@"H_star");
    [self addSubview:star1];
    
    UILabel *starLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, starLabel1.bottom+space, 0, 0)];
    starLabel2.text = @"2";
    starLabel2.font = [UIFont systemFontOfSize:22*MLPercent];
    starLabel2.textColor = MLColor(255, 154, 26);
    [starLabel2 sizeToFit];
    [self addSubview:starLabel2];
    
    UIImageView *star2 = [[UIImageView alloc] initWithFrame:CGRectMake(star1.x, starLabel2.y, 19*MLPercent, 19*MLPercent)];
    star2.image = createImage(@"H_star");
    star2.centerY = starLabel2.centerY;
    [self addSubview:star2];
    
    UILabel *starLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(0, starLabel2.bottom+space, 0, 0)];
    starLabel3.text = @"1";
    starLabel3.font = [UIFont systemFontOfSize:22*MLPercent];
    starLabel3.textColor = MLColor(255, 154, 26);
    [starLabel3 sizeToFit];
    [self addSubview:starLabel3];
    
    UIImageView *star3 = [[UIImageView alloc] initWithFrame:CGRectMake(star1.x, starLabel3.y, 19*MLPercent, 19*MLPercent)];
    star3.image = createImage(@"H_star");
    star3.centerY = starLabel3.centerY;
    [self addSubview:star3];
    
    UILabel *starLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(0, starLabel3.bottom+space, 0, 0)];
    starLabel4.text = @"0";
    starLabel4.font = [UIFont systemFontOfSize:22*MLPercent];
    starLabel4.textColor = MLColor(255, 154, 26);
    [starLabel4 sizeToFit];
    [self addSubview:starLabel4];
    
    UIImageView *star4 = [[UIImageView alloc] initWithFrame:CGRectMake(star1.x, starLabel4.y, 19*MLPercent, 19*MLPercent)];
    star4.image = createImage(@"H_star");
    star4.centerY = starLabel4.centerY;
    [self addSubview:star4];
    
    star3Y = starLabel1.centerY;
    star2Y = starLabel2.centerY;
    star1Y = starLabel3.centerY;
    yWidth = star3.right;
    
}

- (void)createChartScrollView{
    //        NSLog(@"page=%zd",page);
    // Do any additional setup after loading the view, typically from a nib.
    
    graphScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(yWidth+16*MLPercent, 0, self.width-(yWidth+16*MLPercent), self.height)];
    graphScrollView.delegate = self;
    [self addSubview:graphScrollView];
    
    noDatsTipsView = [[UIImageView alloc] initWithFrame:CGRectMake(graphScrollView.x+(graphScrollView.width-279*MLPercent)/2, graphScrollView.y+(graphScrollView.height-139*MLPercent)/2, 279*MLPercent, 139*MLPercent)];
    noDatsTipsView.image = createImage(@"H_noPractiseTips");
    [self addSubview:noDatsTipsView];
    
    myGraph = [[BEMSimpleLineGraphView alloc] initWithFrame:CGRectMake(CHART_X, star3Y-CHART_X, graphScrollView.width*HOLDPAGECOUNT, (star1Y-star2Y)*3+CHART_X*2)];
    myGraph.delegate = self;
    myGraph.dataSource = self;
    [graphScrollView addSubview:myGraph];
    
    myGraph.colorLine = [UIColor colorWithRed:255.0/255 green:155.0/255 blue:33.0/255.0 alpha:1];
    myGraph.widthLine = 2.5*MLPercent;
    myGraph.colorBottom = [UIColor clearColor];
    myGraph.colorTop = [UIColor clearColor];
    myGraph.alwaysDisplayDots = YES;
    myGraph.sizePoint = 22*MLPercent;
    myGraph.colorPoint = [UIColor colorWithRed:255.0/255 green:155.0/255 blue:33.0/255.0 alpha:1];
    myGraph.circleType = BECircleStroke;
    myGraph.animationGraphStyle = BEMLineAnimationNone;
    
    myGraphXAxis = [[UIView alloc] initWithFrame:CGRectMake(0, myGraph.bottom, graphScrollView.width*HOLDPAGECOUNT, xHeight)];
    [graphScrollView addSubview:myGraphXAxis];
    
    
}

- (void)refreshDataWithPage:(NSInteger)page{
    //设置缓存数据
    NSUInteger maxDateLength = MAXPAGEPOINTCOUNT*HOLDPAGECOUNT;
    
    if (maxDateLength>self.starValueArr.count) {
        maxDateLength = self.starValueArr.count;
    }
    if (page>=1) {
        page = page-1;
    }
    
    if ((self.starValueArr.count-page*MAXPAGEPOINTCOUNT)<maxDateLength) {
        maxDateLength = self.starValueArr.count-page*MAXPAGEPOINTCOUNT;
    }

    self.starTempValueArr = [self.starValueArr subarrayWithRange:NSMakeRange(page*MAXPAGEPOINTCOUNT, maxDateLength)];
    
    //刷新表格
    myGraph.x = page*graphScrollView.width+CHART_X;
    myGraph.width = maxDateLength*(graphScrollView.width*1.0/MAXPAGEPOINTCOUNT);
    
    if (self.curSelectIndex>=page*MAXPAGEPOINTCOUNT&&self.curSelectIndex<=(page*MAXPAGEPOINTCOUNT+maxDateLength)) {
        myGraph.isHaveSelect = YES;
    }else{
        myGraph.isHaveSelect = NO;
    }
    myGraph.curSelectIndex = _curSelectIndex-page*MAXPAGEPOINTCOUNT;
    [myGraph reloadGraph];
    
    //刷新x轴
    [self reloadXAxis];
    
}

- (void)reloadXAxis{
    [myGraphXAxis.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    myGraphXAxis.x = myGraph.x-CHART_X;
    myGraphXAxis.width = myGraph.width;
    
    
    NSString *lastMonthDay = @"";
    if (self.starTempValueArr.count>0) {
        LNLineChartModel *model = [self.starTempValueArr objectAtIndex:0];
        lastMonthDay =[self getMonthDayWithDateStr:model.playDate];
    }
    CGPoint beginPoint = CGPointMake(0, 0);
    
    // 需要画线的视图
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(beginPoint.x, myGraphXAxis.height/2, myGraphXAxis.width, 1*MLPercent)];
    [myGraphXAxis addSubview:lineView];
    
    for (int i =0; i<self.starTempValueArr.count; i++) {
        UILabel *xLabel = [[UILabel alloc] initWithFrame:CGRectMake(i*(graphScrollView.width*1.0/MAXPAGEPOINTCOUNT), 0, 40*MLPercent, 22*MLPercent)];
        LNLineChartModel *model = [self.starTempValueArr objectAtIndex:i];
        xLabel.text = [self getMinuteSecondWithDateStr:model.playDate];
        xLabel.font = [UIFont systemFontOfSize:16*MLPercent];
        xLabel.textColor = MLGrayColor(115);
        xLabel.adjustsFontSizeToFitWidth = YES;
        
        if (self.starTempValueArr.count==1) {
            xLabel.x = 0;
        }else{
            xLabel.centerX = (myGraph.width/(self.starTempValueArr.count - 1)) * i+CHART_X;
        }
        
        [myGraphXAxis addSubview:xLabel];
        
        // 线的路径
        UIBezierPath *linePath = [UIBezierPath bezierPath];
        [linePath moveToPoint:beginPoint];
        CAShapeLayer *lineLayer = [CAShapeLayer layer];
        lineLayer.lineWidth = 1*MLPercent;
        lineLayer.strokeColor = MLColor(255, 155, 33).CGColor;
        lineLayer.fillColor = MLColor(255, 155, 33).CGColor;
        
        [linePath addLineToPoint:CGPointMake(xLabel.right, beginPoint.y)];
        beginPoint = CGPointMake(xLabel.right, beginPoint.y);
        
        if (i == 0) {
            xLabel.x = 0;
            UILabel *monthLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, myGraphXAxis.height-22*MLPercent, 40*MLPercent, 22*MLPercent)];
            monthLabel.textAlignment = NSTextAlignmentCenter;
            monthLabel.text = lastMonthDay;
            monthLabel.font = [UIFont systemFontOfSize:16*MLPercent];
            monthLabel.textColor = MLColor(255, 155, 33);
            monthLabel.adjustsFontSizeToFitWidth = YES;
            [myGraphXAxis addSubview:monthLabel];
  
        }else{
            NSString *curMonthDay =[self getMonthDayWithDateStr:model.playDate];
            
            
            if (curMonthDay!=lastMonthDay) {//添加日期Label
                
                lastMonthDay = curMonthDay;
                UILabel *monthLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, myGraphXAxis.height-22*MLPercent, 40*MLPercent, 22*MLPercent)];
                monthLabel.centerX = (myGraph.width/(self.starTempValueArr.count - 1)) * i+CHART_X;
                monthLabel.textAlignment = NSTextAlignmentCenter;
                monthLabel.text = lastMonthDay;
                monthLabel.font = [UIFont systemFontOfSize:16*MLPercent];
                monthLabel.textColor = MLColor(255, 155, 33);
                monthLabel.adjustsFontSizeToFitWidth = YES;
                [myGraphXAxis addSubview:monthLabel];
                
                [linePath removeAllPoints];
                [linePath moveToPoint:CGPointMake(xLabel.x, beginPoint.y)];
                CAShapeLayer *lineLayer = [CAShapeLayer layer];
                lineLayer.lineWidth = 1*MLPercent;
                lineLayer.strokeColor = MLColor(255, 155, 33).CGColor;
                lineLayer.fillColor = MLColor(255, 155, 33).CGColor;
                
                [linePath addLineToPoint:CGPointMake(xLabel.right, beginPoint.y)];
                beginPoint = CGPointMake(xLabel.right, beginPoint.y);
                
            }
        }
        lineLayer.path = linePath.CGPath;
        [lineView.layer addSublayer:lineLayer];
    }
}


#pragma mark - <BEMSimpleLineGraphViewDateSource>
- (NSInteger)numberOfPointsInLineGraph:(BEMSimpleLineGraphView *)graph
{
    return self.starTempValueArr.count;
}

- (CGFloat)lineGraph:(BEMSimpleLineGraphView *)graph valueForPointAtIndex:(NSInteger)index
{
    LNLineChartModel *model = [self.starTempValueArr objectAtIndex:index];
    return model.star;
}


-(CGFloat)staticPaddingForLineGraph:(BEMSimpleLineGraphView *)graph
{
    return CHART_X*2;
}

- (CGFloat)minValueForLineGraph:(BEMSimpleLineGraphView *)graph
{
    return 0;
}

- (CGFloat)maxValueForLineGraph:(BEMSimpleLineGraphView *)graph{
    return 3;
}

-(void)lineGraph:(BEMSimpleLineGraphView *)graph didTouchDotWithIndex:(NSInteger)index{
    
    NSInteger tempPage = curPage;
    //设置缓存数据
    NSUInteger maxDateLength = MAXPAGEPOINTCOUNT*HOLDPAGECOUNT;
    if (maxDateLength>self.starValueArr.count) {
        maxDateLength = self.starValueArr.count;
    }
    if (tempPage>=1) {
        tempPage = tempPage-1;
    }
    NSInteger beginCount = tempPage*MAXPAGEPOINTCOUNT;
    
    NSInteger selectIndex = beginCount+index;
    self.curSelectIndex = selectIndex;
    
    LNLineChartModel *starInfoModel = [LNLineChartModel mj_objectWithKeyValues:_starInfoArr[selectIndex]];
    if ([self.delegate respondsToSelector:@selector(chartViewDotsTouchWithIndex:model:)]) {
        [self.delegate chartViewDotsTouchWithIndex:selectIndex model:starInfoModel];
    }
}

#pragma mark - <scrollDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
//    NSLog(@"offsetX = %lf",offsetX);
    
    if (offsetX>0&&offsetX<=scrollView.contentSize.width-scrollView.width) {
        int page = offsetX/scrollView.width;
//        NSLog(@"page=%zd",page);
        if (curPage!=page) {//改变页重绘
            curPage = page;
//            NSLog(@"重绘curPage=%zd",curPage);
            //            if (curPage>=HOLDPAGECOUNT-1) {
            [self refreshDataWithPage:curPage];
            //            }
            
        }
    }
}

#pragma mark - 刷新数据
- (void)setStarInfoArr:(NSArray *)starInfoArr
{
    _starInfoArr = starInfoArr;
    
    if (!self.starValueArr) self.starValueArr = [[NSMutableArray alloc] init];
    [self.starValueArr removeAllObjects];
    
    //筛选按同一天分类
    for (int i = 0; i<starInfoArr.count; i++) {
        LNLineChartModel *starInfoModel = [LNLineChartModel mj_objectWithKeyValues:starInfoArr[i]];
        [self.starValueArr addObject:starInfoModel];
        
        if (i==starInfoArr.count-1) {
            if ([self.delegate respondsToSelector:@selector(refreshLatestObjectWithDateStr:star:)]) {
                [self.delegate refreshLatestObjectWithDateStr:starInfoModel.playDate star:starInfoModel.star];
            }
        }
    }
    
    
    
    if (self.starValueArr.count==0) {
        if ([self.delegate respondsToSelector:@selector(refreshLatestObjectWithDateStr:star:)]) {
            [self.delegate refreshLatestObjectWithDateStr:@"" star:0];
        }
        noDatsTipsView.hidden = NO;
    }else{
        noDatsTipsView.hidden = YES;
    }
    
    [self refreshChart];
}

- (void)refreshChart{
//    /*****测试数据****/
//    if (!self.starValueArr) self.starValueArr = [[NSMutableArray alloc] init];
//    [self.starValueArr removeAllObjects];
//    
//    //制造数据
//    int totalCount = 1000;
//    for (int i = 0; i < totalCount; i++) {
//        [self.starValueArr addObject:@((i%4+i%3)%4)];
//    }
//    /*****测试数据****/
    
    NSInteger totalCount = self.starValueArr.count;
    
    totalPages = 1;
    NSUInteger subPointCount = totalCount%MAXPAGEPOINTCOUNT;
    CGFloat inspectX = 0;
    if (subPointCount==0) {
        totalPages = totalCount/MAXPAGEPOINTCOUNT;
    }else{
        totalPages = totalCount/MAXPAGEPOINTCOUNT+1;
        inspectX = (MAXPAGEPOINTCOUNT-subPointCount)*(graphScrollView.width*1.0/MAXPAGEPOINTCOUNT);
    }
    
    [graphScrollView setContentSize:CGSizeMake(totalPages*graphScrollView.width-inspectX+CHART_X*2, graphScrollView.height)];
    
    CGFloat contentOffsetX = totalPages*graphScrollView.width-inspectX+CHART_X*2-graphScrollView.width;

    if(contentOffsetX<0)contentOffsetX=0;
    
    [graphScrollView setContentOffset:CGPointMake(contentOffsetX, 0)];
    int page = contentOffsetX/graphScrollView.width;
    curPage = page;
    self.curSelectIndex = self.starInfoArr.count-1;
    [self refreshDataWithPage:page];
}


- (NSString *)getMinuteSecondWithDateStr:(NSString *)dateStr{
    return [[self minuteFormatter] stringFromDate:[[self formatter] dateFromString:dateStr]];
}

- (NSString *)getMonthDayWithDateStr:(NSString *)dateStr{
    return [[self monthFormatter] stringFromDate:[[self formatter] dateFromString:dateStr]];
}

- (NSDateFormatter *)formatter {
    
    if(! _formatter) {
        _formatter = [[NSDateFormatter alloc] init];
        _formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";// twitter date format
        NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
        _formatter.timeZone = sourceTimeZone;
    }
    return _formatter;
}

- (NSDateFormatter *)minuteFormatter
{
    if(! _minuteFormatter) {
        _minuteFormatter = [[NSDateFormatter alloc] init];
        _minuteFormatter.dateFormat = @"HH:mm";// twitter date format
        NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
        _minuteFormatter.timeZone = sourceTimeZone;
    }
    return _minuteFormatter;
}

- (NSDateFormatter *)monthFormatter{
    if(! _monthFormatter) {
        _monthFormatter = [[NSDateFormatter alloc] init];
        _monthFormatter.dateFormat = @"MM-dd";// twitter date format
        NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
        _monthFormatter.timeZone = sourceTimeZone;
    }
    return _monthFormatter;
}

@end
