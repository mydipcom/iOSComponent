//
//  UIColor+Hex.h
//  Jason
//
//  Created by Jason on 13-11-7.
//  Copyright (c) 2013年 Jason All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor(Hex)

/**
 *  转换十六进制颜色
 *
 *  @param hexColor 十六进制颜色 eg: 0xffffff
 *
 *  @return
 */
+ (UIColor *)colorWithHex:(long)hexColor;

/**
 *  转换十六进制颜色
 *
 *  @param hexColor 十六进制颜色 eg: 0xffffff
 *  @param opacity  颜色透明度
 *
 *  @return
 */
+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity;

@end
