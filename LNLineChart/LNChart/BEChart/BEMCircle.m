//
//  BEMCircle.m
//  SimpleLineGraph
//
//  Created by Bobo on 12/27/13. Updated by Sam Spencer on 1/11/14.
//  Copyright (c) 2013 Boris Emorine. All rights reserved.
//  Copyright (c) 2014 Sam Spencer.
//

#import "BEMCircle.h"

@implementation BEMCircle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    if (self.isLastes) {
        self.circleType = BECirclePurpleFill;
    }else{
        self.circleType = BECircleOrangeFill;
    }
    
    switch (self.circleType) {
        case BECircleStroke:{
            CGFloat insetW = 5*MLPercent;
            CGRect samllRect = CGRectMake(rect.origin.x + insetW,
                                          rect.origin.y + insetW,
                                          rect.size.width - 2 * insetW,
                                          rect.size.height - 2 * insetW);
            
            CGContextAddEllipseInRect(ctx, samllRect);
            [[UIColor whiteColor] setFill];
            CGContextFillPath(ctx);
            
            CGFloat kBorderWith = 2.5*MLPercent;
            samllRect = CGRectMake(rect.origin.x + insetW+kBorderWith/2,
                                   rect.origin.y + insetW+kBorderWith/2,
                                   rect.size.width - 2 *(insetW+kBorderWith/2),
                                   rect.size.height - 2 * (insetW+kBorderWith/2));
            CGContextSetLineWidth(ctx, kBorderWith);
            CGContextAddEllipseInRect(ctx, samllRect);
            [[UIColor colorWithRed:255.0/255 green:155.0/255 blue:33.0/255 alpha:1] set];
            CGContextStrokePath(ctx);
            break;
        }
        case BECircleOrangeFill:{
            CGContextAddEllipseInRect(ctx, CGRectMake(rect.origin.x + DefaultOneH,
                                                      rect.origin.y + DefaultOneH,
                                                      rect.size.width - 2 * DefaultOneH,
                                                      rect.size.height - 2 * DefaultOneH));
            [[UIColor colorWithRed:255.0/255 green:155.0/255 blue:33.0/255 alpha:1] setFill];
            CGContextFillPath(ctx);
            
            CGFloat kBorderWith = 5*MLPercent;
            CGRect samllRect = CGRectMake(rect.origin.x + kBorderWith/2,
                                          rect.origin.y + kBorderWith/2,
                                          rect.size.width - 2 * kBorderWith/2,
                                          rect.size.height - 2 * kBorderWith/2);
            
            CGContextSetLineWidth(ctx, kBorderWith);
            CGContextAddEllipseInRect(ctx, samllRect);
            [[UIColor colorWithRed:255.0/255 green:230.0/255 blue:200.0/255 alpha:1] set];
            CGContextStrokePath(ctx);
            break;
        }case BECirclePurpleFill:{
            CGContextAddEllipseInRect(ctx, CGRectMake(rect.origin.x + DefaultOneH,
                                                      rect.origin.y + DefaultOneH,
                                                      rect.size.width - 2 * DefaultOneH,
                                                      rect.size.height - 2 * DefaultOneH));
            [[UIColor colorWithRed:123.0/255 green:75.0/255 blue:255.0/255 alpha:1] setFill];
            
            CGContextFillPath(ctx);
            
            CGFloat kBorderWith = 5*MLPercent;
            CGRect samllRect = CGRectMake(rect.origin.x + kBorderWith/2,
                                          rect.origin.y + kBorderWith/2,
                                          rect.size.width - 2 * kBorderWith/2,
                                          rect.size.height - 2 * kBorderWith/2);
            
            CGContextSetLineWidth(ctx, kBorderWith);
            CGContextAddEllipseInRect(ctx, samllRect);
            [[UIColor colorWithRed:228.0/255 green:218.0/255 blue:255.0/255 alpha:1] set];
            CGContextStrokePath(ctx);
            break;
        }
        default:{
            CGContextAddEllipseInRect(ctx, rect);
            [self.Pointcolor set];
            CGContextFillPath(ctx);
            break;
        }
    }
}

- (void)setIsLastes:(BOOL)isLastes{
    _isLastes = isLastes;
    [self setNeedsDisplay];
}

@end
