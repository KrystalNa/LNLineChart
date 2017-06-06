//
//  UIView+MLExtension.h
//  pianoteiphone
//
//  Created by Doris on 15/12/1.
//  Copyright © 2015年 阎. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MLExtension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat right;

/** 从xib中创建一个控件 */
+ (instancetype)viewFromXib;
@end
