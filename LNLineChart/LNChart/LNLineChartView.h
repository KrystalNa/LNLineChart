//
//  LNLineChartView.h
//  pianoteiphone
//
//  Created by Doris on 2017/3/31.
//  Copyright © 2017年 阎. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LNLineChartModel.h"

@protocol LNLineChartViewDelegate <NSObject>
/**点击线上的点时回调*/
- (void)chartViewDotsTouchWithIndex:(NSInteger)index model:(LNLineChartModel *)model;
/**默认选中最近一个点执行事件*/
- (void)refreshLatestObjectWithDateStr:(NSString *)dateStr star:(NSInteger)star;
@end

@interface LNLineChartView : UIView
@property (nonatomic,weak) id<LNLineChartViewDelegate> delegate;/**< */

@property (nonatomic,strong) NSArray *starInfoArr;

@property (nonatomic,assign) NSInteger curSelectIndex;/**< */
@end
