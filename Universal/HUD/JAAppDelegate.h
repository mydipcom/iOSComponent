//
//  JAAppDelegate.h
//  UIViewAnimation
//
//  Created by CAMPRAY-MAC1 on 14-9-11.
//  Copyright (c) 2014年 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JAAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
+ (JAAppDelegate*)shareDelegate;
// - Alert
- (void)alert:(NSString*)text;
- (void)alert:(NSString*)text withTitle:(NSString*)title;
- (void)waitingAlert:(NSString*)text;
- (void)waitingAlert:(NSString*)text withTitle:(NSString*)title;
- (void)hideAlert;
- (void)hideAlertAfterDelay:(NSTimeInterval)delay;
@end
