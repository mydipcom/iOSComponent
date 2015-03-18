//
//  ComMacro.h
//
//  ProjectName_ComMacro_h 根据工程名来更改 ProjectName
//
//  Created by Jason on 15-1-12.
//  通用头文件
//

#ifndef ProjectName_ComMacro_h
#define ProjectName_ComMacro_h

/**
 *  YES: iOS8 以及 iOS8 以后的系统
 */
#define iOS8_later [[[UIDevice currentDevice]systemVersion]floatValue] >= 8.0

/**
 *  NSlog在发布时不起作用
 */
#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#define debugMethod() NSLog(@"%s", __func__)
#else
#define NSLog(...)
#define debugMethod()
#endif

/**
 *  多语言处理 infoPlist 为string的名字
 */
#define writeText(Str)      NSLocalizedStringFromTable (Str,@"InfoPlist", nil)

#endif
