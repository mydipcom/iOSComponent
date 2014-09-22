//
//  JAMBProgressHUD.h
//  UIViewAnimation
//
//  Created by CAMPRAY-MAC1 on 14-9-19.
//  Copyright (c) 2014年 Jason. All rights reserved.
//  JAMBProgressHUD just for Jason's Projects. 

#import "MBProgressHUD.h"

@interface JAMBProgressHUD : MBProgressHUD

/**
 * HUD background frame orign y offset
 * eg.             
 * _hud.yBgOffset = 64;
 * _hud.yOffset = -64;
 * since:1.0.0
 */
@property (assign) float yBgOffset;
@end
