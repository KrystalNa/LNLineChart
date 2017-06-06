//
//  UIButton+MLExtension.m
//  pianoteiphone
//
//  Created by Doris on 16/4/8.
//  Copyright © 2016年 阎. All rights reserved.
//

#import "UIButton+MLExtension.h"

@implementation UIButton (MLExtension)
+ (void)animateButton:(UIButton*)button frame:(CGRect)frame offimagenames:(NSArray*)imagenames startdelay:(const NSTimeInterval)STARTDELAY {
    UIImageView* imageview = [button imageView];
//    imageview.frame = frame;
    NSMutableArray* images = [NSMutableArray array];
    for (NSString* imagename in imagenames) {
        UIImage* image = [UIImage imageNamed:imagename];
        NSAssert(image != nil, @"Failed loading imagename: %@", imagename);
        if (image == nil)
            return; // return out here... whatever
        [images addObject:image];
    }
    imageview.image = images.firstObject;
    [button addSubview:imageview];
    imageview.animationImages = images;
    imageview.animationDuration = 2;
    imageview.animationRepeatCount = MAXFLOAT;
    [imageview performSelector:@selector(startAnimating) withObject:nil afterDelay:STARTDELAY]; // [imageview startAnimating];
}
@end
