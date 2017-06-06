//
//  UIFont+MLExtension.m
//  pianoteiphone
//
//  Created by Doris on 17/1/10.
//  Copyright © 2017年 阎. All rights reserved.
//

#import "UIFont+MLExtension.h"

@implementation UIFont (MLExtension)
+ (UIFont *)fontName:(NSString *)fontName size:(CGFloat)fontSize
{
    if (fontName==nil||[fontName isEqualToString:@""]) {
        return [self systemFontOfSize:fontSize];
    }else{
        return [self fontWithName:fontName size:fontSize];
    }
}
@end
