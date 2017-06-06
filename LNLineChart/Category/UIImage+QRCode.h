//
//  UIImage+QRCode.h
//  生成二维码
//
//  Created by doris on 15/11/19.
//  Copyright © 2015年 doris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (QRCode)

+ (UIImage *)createNonInterpolatedUIImageFromCIImage:(CIImage *)image withSize:(CGFloat) size;

@end
