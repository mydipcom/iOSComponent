//
//  NSDictionary+safeObjectForKey.h
//  toelibrary
//
//  Created by Jason on 14-7-25.
//  Copyright (c) 2014年 Jason All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSDictionary (safeObjectForKey)

// 常用方法
- (BOOL)getBoolValueForKey:(NSString *)key defaultValue:(BOOL)defaultValue;
- (int)getIntValueForKey:(NSString *)key defaultValue:(int)defaultValue;
- (time_t)getTimeValueForKey:(NSString *)key defaultValue:(time_t)defaultValue;
- (long long)getLongLongValueValueForKey:(NSString *)key defaultValue:(long long)defaultValue;
- (NSString *)getStringValueForKey:(NSString *)key defaultValue:(NSString *)defaultValue;
- (float)getFloatValueForKey:(NSString*)key defaultValue:(float)defaultValue;

// 二次扩展方法
- (NSString *)safeObjectForKey:(id)key;
- (NSNumber *)getIntNumberForKey:(NSString *)key defaultValue:(int) defaultValue;
- (NSNumber *)getBoolNumberForKey:(NSString *)key defaultValue:(BOOL) defaultValue;
- (NSNumber *)getFloatNumberForKey:(NSString *)key defaultValue:(float) defaultValue;

@end

