//
//  BEMCircle.h
//  SimpleLineGraph
//
//  Created by Bobo on 12/27/13. Updated by Sam Spencer on 1/11/14.
//  Copyright (c) 2013 Boris Emorine. All rights reserved.
//  Copyright (c) 2014 Sam Spencer.
//

@import Foundation;
@import UIKit;
@import CoreGraphics;


typedef enum _BECircelStypeType{
    BECircleDefault,
    BECircleStroke,
    BECircleOrangeFill,
    BECirclePurpleFill,
}BECircelStypeType;


/// Class to draw the circle for the points.
@interface BEMCircle : UIView

/// Set to YES if the data point circles should be constantly displayed. NO if they should only appear when relevant.
@property (assign, nonatomic) BOOL shouldDisplayConstantly;

/// The point color
@property (strong, nonatomic) UIColor *Pointcolor;

/// The value of the point
@property (nonatomic) CGFloat absoluteValue;

@property (nonatomic,assign) BOOL isLastes;/**< Y-最近的一次紫色*/

@property (nonatomic,assign) BECircelStypeType circleType;/**< Y-最高点(样式不一样)*/

@end
