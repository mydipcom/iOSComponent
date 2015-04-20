//
//  CBNavigationController.m
//  iOS7-NavigationController-Sample
//
//  Created by CampRay-Jason on 15/4/17.
//
//

#import "SHNavigationController.h"

@interface SHNavigationController()<UINavigationControllerDelegate, UIGestureRecognizerDelegate>
@end

@implementation SHNavigationController

- (void)viewDidLoad
{
    __weak SHNavigationController *weakSelf = self;
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
        self.delegate = weakSelf;
    }
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
        self.interactivePopGestureRecognizer.enabled = NO;
    
    [super pushViewController:viewController animated:animated];
}

#pragma mark UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate
{
    
    // 保证 不是在 root vc，在root vc 时应该禁用 手势返回
    if (![self isRootViewController] && [self respondsToSelector:@selector(interactivePopGestureRecognizer)]){
        self.interactivePopGestureRecognizer.enabled = YES;
    }else{
        self.interactivePopGestureRecognizer.enabled = NO;
    }
}

#pragma private function
// 在root view 时，让手势获取无效
- (BOOL)isRootViewController
{
    // 当 navagation 中只有root vc 时
    if (self.viewControllers.count == 1){
        return YES;
    }else{
        return NO;
    }
}

@end