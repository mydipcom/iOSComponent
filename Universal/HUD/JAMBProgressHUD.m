//
//  JAMBProgressHUD.m
//  UIViewAnimation
//
//  Created by CAMPRAY-MAC1 on 14-9-19.
//  Copyright (c) 2014年 Jason. All rights reserved.
//  JAMBProgressHUD just for Jason's Projects.

#import "JAMBProgressHUD.h"

@implementation JAMBProgressHUD

/*
 * overwrite -(void)lyoutSubviews; add setting self.frame by yBgOffset
 *
 * since: 1.0.0
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    UIView *parent = self.superview;
    CGRect bgOffsetFrame = parent.bounds;
    bgOffsetFrame.origin.y = self.yBgOffset;
    if (parent) {
        self.frame = bgOffsetFrame;
    }
}
@end
