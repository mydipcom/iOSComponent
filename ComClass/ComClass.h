//
//  ComClass.h
//
//
//  通用类，处理极具通用性的类方法。
//
//
//  Created by Jason on 14-11-12.
//  Copyright (c) 2014年 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ComClass : NSObject
/**
 *  计算 被弹出键盘遮挡的 uiview 相对 转化成父类位置坐标。
 *
 *  @param sheldedView
 *  @param sheldSupView
 *  @param view         如 self.view
 *
 *  @return seldedview需要移动float距离 避开遮挡
 */
+ (float)calaSheldByKeyBoardWithView:(UIView *) sheldedView SupView:(UIView *) sheldSupView SelfView:(UIView *) view;

/**
 *  利用UIMotionEffect给View添加视差效果，iOS7 及以上
 *
 *  @param _effectView
 *  @param _depthF
 */
+ (void)registerEffectForView:(UIView*)_effectView depth:(CGFloat)_depthF;

@end
