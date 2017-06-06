//
//  ViewController.m
//  LNLineChart
//
//  Created by Doris on 2017/6/6.
//  Copyright © 2017年 Doris. All rights reserved.
//

#import "ViewController.h"
#import "LNLineChartView.h"

@interface ViewController ()<LNLineChartViewDelegate>
{
    LNLineChartView *chartView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    chartView = [[LNLineChartView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 208)];
    chartView.delegate = self;
    [self.view addSubview:chartView];
    
    
    NSMutableArray *chartDataArr = [[NSMutableArray alloc] init];
    for (int i = 0; i<100; i++) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        if (i<20) {
            dict[@"star"] = [NSNumber numberWithInt:i%4];
            dict[@"playDate"] = @"2017-06-01 18:05:51";
        }else{
            dict[@"star"] = [NSNumber numberWithInt:i%4];
            dict[@"playDate"] = @"2017-06-04 18:05:51";
        }
        [chartDataArr addObject:dict];
    }
    
     chartView.starInfoArr = chartDataArr;
}

#pragma mark - <LNLineChartViewDelegate>
- (void)refreshLatestObjectWithDateStr:(NSString *)dateStr star:(NSInteger)star
{
    
}

- (void)chartViewDotsTouchWithIndex:(NSInteger)index model:(LNLineChartModel *)model
{
    [self refreshLatestObjectWithDateStr:model.playDate star:model.star];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
