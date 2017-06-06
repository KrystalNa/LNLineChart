//
//  UIImage+MLExtension.m
//  MelomeloTeacher
//
//  Created by Doris on 16/8/8.
//  Copyright © 2016年 阎. All rights reserved.
//

#import "UIImage+MLExtension.h"

@implementation UIImage (MLExtension)

- (UIImage *)drawRectWithRoundedCornerWithRadius:(CGFloat)radius size:(CGSize)sizetoFit{
    
    CGRect rect = CGRectMake(0, 0, sizetoFit.width, sizetoFit.height);
     UIGraphicsBeginImageContextWithOptions(rect.size, false, [UIScreen mainScreen].scale);
    CGContextAddPath(UIGraphicsGetCurrentContext(),
                     [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)].CGPath);
    CGContextClip(UIGraphicsGetCurrentContext());
    [self drawInRect:rect];
    
    CGContextDrawPath(UIGraphicsGetCurrentContext(), kCGPathFillStroke);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
