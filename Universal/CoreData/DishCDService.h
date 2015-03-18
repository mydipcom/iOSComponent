//
//  DishCDService.h
//  
//
//  Created by Jason on 14-12-26.
//
//

#import <Foundation/Foundation.h>
#import "CoreDataService.h"
#warning DishCDModel 是自己创建的coredata对象名
#import "DishCDModel.h"

@interface DishCDService : NSObject
/**
 *  获取所有 菜品
 *
 *  @return dishModel mut arr 返回的是 DishModel 对象数组
 */
+ (NSMutableArray*)queryProducts;

/**
 *  通过 menuID 查询 分类下的所有的菜品
 *
 *  @return 返回的是 DishModel 对象数组
 */
+ (NSMutableArray*)queryDishsByMenuId:(int) menuId;

/**
 *  插入dish
 *
 *  @param
 */
+ (void)insertDish:(NSDictionary *)dish;

/**
 *  删除菜品 by productId
 *
 *  @param
 */
+ (void)deleteDishByProductId:(int) productId;

/**
 *  更新菜品 by productId
 *
 *  @param
 */
+ (void)updateDishByProductId:(NSDictionary *)dish;

+ (void)cleanDishs;
@end
