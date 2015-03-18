//
//  ComClass.m
//
//
//  Created by Jason on 14-11-12.
//  Copyright (c) 2014年 Jason. All rights reserved.
//

#import "ComClass.h"

@implementation ComClass

+ (float)calaSheldByKeyBoardWithView:(UIView *) sheldedView SupView:(UIView *) sheldSupView SelfView:(UIView *) view{
    float deltaFload = 0;
    if (sheldedView != nil) {
        // 转换坐标
        CGRect sheldedViewForSelfViewRect = [sheldedView convertRect:sheldedView.frame toView:sheldSupView];
        // 判断keyboard是否与sheldeeview 遮挡
        deltaFload = sheldedViewForSelfViewRect.origin.y+sheldedViewForSelfViewRect.size.height/2-(view.frame.size.height - 216 - 10);
        if (deltaFload > 0){
            return deltaFload;
        }else{
            return 0;
        }
    }else{
        deltaFload = CGRectGetMaxY(sheldSupView.frame) -(view.frame.size.height - 216 - 10);
        if (deltaFload > 0){
            return deltaFload;
        }else{
            return 0;
        }
    }
    
    return deltaFload;
    
}

+ (void)registerEffectForView:(UIView*)_effectView depth:(CGFloat)_depthF
{
    
    UIInterpolatingMotionEffect *effectX;
    
    UIInterpolatingMotionEffect *effectY;
    
    effectX = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];

    effectY = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    
    effectX.maximumRelativeValue = @(_depthF);
    
    effectX.minimumRelativeValue = @(-_depthF);
    
    effectY.maximumRelativeValue = @(_depthF);
    
    effectY.minimumRelativeValue = @(-_depthF);
    
    [_effectView addMotionEffect:effectX];
    
    [_effectView addMotionEffect:effectY];
    
}
@end
