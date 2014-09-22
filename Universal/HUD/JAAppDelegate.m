//
//  JAAppDelegate.m
//  UIViewAnimation
//
//  Created by CAMPRAY-MAC1 on 14-9-11.
//  Copyright (c) 2014年 Jason. All rights reserved.
//

#import "JAAppDelegate.h"
#import "JAMBProgressHUD.h"
#define Upload_Request_Max_Timeout 15

@implementation JAAppDelegate{
    JAMBProgressHUD *_hud;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

+ (JAAppDelegate*)shareDelegate
{
    return (JAAppDelegate*)[[UIApplication sharedApplication] delegate];
}

#pragma mark - Alert
- (BOOL)createHudIfNeeded {
    BOOL ok = NO;
    
    
    if (self.window) {
        if (_hud == nil) {
            _hud = [[JAMBProgressHUD alloc] initWithWindow:self.window];
            _hud.dimBackground = YES;
// 设置 BackGround 向下移动位置 eg.
//            _hud.yBgOffset = 64;
//             _hud.yOffset = -64;
            _hud.detailsLabelFont = [UIFont systemFontOfSize:20];
            [self.window addSubview:_hud];
        }
        ok = YES;
    }
    
    return ok;
}
- (void)alert:(NSString*)text {
    [self alert:text withTitle:nil];
}

- (void)alert:(NSString*)text withTitle:(NSString*)title {
    if ([self createHudIfNeeded]) {
        [NSObject cancelPreviousPerformRequestsWithTarget:_hud];
        _hud.mode = MBProgressHUDModeText;
        _hud.labelText = title;
        _hud.detailsLabelText = text;
       
        [_window bringSubviewToFront:_hud];
        
        [_hud show:YES];
        [self hideAlertAfterDelay:1.5];
    }
}

- (void)waitingAlert:(NSString*)text {
    [self waitingAlert:text withTitle:nil];
}

- (void)waitingAlert:(NSString*)text withTitle:(NSString*)title {
    if ([self createHudIfNeeded]) {
        [NSObject cancelPreviousPerformRequestsWithTarget:_hud];
        _hud.mode = MBProgressHUDModeIndeterminate;
        _hud.labelText = title;
        _hud.detailsLabelText = text;
        [_window bringSubviewToFront:_hud];
        [_hud show:YES];
        [self hideAlertAfterDelay:Upload_Request_Max_Timeout];
    }
}

- (void)hideAlert {
    [self hideAlertAfterDelay:0.3];
}

- (void)hideAlertAfterDelay:(NSTimeInterval)delay {
    [NSObject cancelPreviousPerformRequestsWithTarget:_hud];
    [_hud hide:YES afterDelay:delay];
}

@end
