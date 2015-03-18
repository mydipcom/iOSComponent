//
//  UIColor+Hex.m
//  
//
//  Created by Jason on 13-11-7.
//  Copyright (c) 2013年 Jason All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor(Hex)


+ (UIColor*) colorWithHex:(long)hexColor;
{
    return [UIColor colorWithHex:hexColor alpha:1.0];
}

+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity
{
float red = ((float)((hexColor & 0xFF0000) >> 16))/255.0;
    float green = ((float)((hexColor & 0xFF00) >> 8))/255.0;
    float blue = ((float)(hexColor & 0xFF))/255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:opacity];
}

@end
