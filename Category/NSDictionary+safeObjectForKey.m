//
//  NSDictionary+safeObjectForKey.m
//  toelibrary
//
//  Created by Jason on 14-7-25.
//  Copyright (c) 2014年 Jason All rights reserved.
//

#import "NSDictionary+safeObjectForKey.h"
#define checkNull(__X__)        (__X__) == [NSNull null] || (__X__) == nil ? @"" : [NSString stringWithFormat:@"%@", (__X__)]


@implementation NSDictionary (safeObjectForKey)


- (NSString *)safeObjectForKey:(id)key
{
    return checkNull([self objectForKey:key]);
}

- (NSNumber *)getIntNumberForKey:(NSString *)key defaultValue:(int) defaultValue{
    return [self objectForKey:key] == [NSNull null] ? [NSNumber numberWithInt:defaultValue]
    : [self objectForKey:key];
}
- (NSNumber *)getBoolNumberForKey:(NSString *)key defaultValue:(BOOL) defaultValue{
    return [self objectForKey:key] == [NSNull null] ? [NSNumber numberWithBool:defaultValue]
    : [self objectForKey:key];
}
- (NSNumber *)getFloatNumberForKey:(NSString *)key defaultValue:(float) defaultValue{
    return [self objectForKey:key] == [NSNull null] ? [NSNumber numberWithFloat:defaultValue]
    : [self objectForKey:key];
}

- (BOOL)getBoolValueForKey:(NSString *)key defaultValue:(BOOL)defaultValue {
    return [self objectForKey:key] == [NSNull null] ? defaultValue
    : [[self objectForKey:key] boolValue];
}

- (int)getIntValueForKey:(NSString *)key defaultValue:(int)defaultValue {
    return ([self objectForKey:key] == [NSNull null] || [self objectForKey:key] == nil)
				? defaultValue : [[self objectForKey:key] intValue];
}

- (float)getFloatValueForKey:(NSString*)key defaultValue:(float)defaultValue{
    return [self objectForKey:key] == [NSNull null]
    ? defaultValue : [[self objectForKey:key] intValue];
}
- (time_t)getTimeValueForKey:(NSString *)key defaultValue:(time_t)defaultValue {
    NSString *stringTime   = [self objectForKey:key];
    if ((id)stringTime == [NSNull null]) {
        stringTime = @"";
    }
    struct tm created;
    time_t now;
    time(&now);
    
    if (stringTime) {
        if (strptime([stringTime UTF8String], "%a %b %d %H:%M:%S %z %Y", &created) == NULL) {
            strptime([stringTime UTF8String], "%a, %d %b %Y %H:%M:%S %z", &created);
        }
        return mktime(&created);
    }
    return defaultValue;
}

- (long long)getLongLongValueValueForKey:(NSString *)key defaultValue:(long long)defaultValue {
    return [self objectForKey:key] == [NSNull null]
    ? defaultValue : [[self objectForKey:key] longLongValue];
}

- (NSString *)getStringValueForKey:(NSString *)key defaultValue:(NSString *)defaultValue {
    return [self objectForKey:key] == nil || [self objectForKey:key] == [NSNull null]
				? defaultValue : [self objectForKey:key];
}

@end