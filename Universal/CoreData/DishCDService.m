//
//  DishCDService.m
//
//
//  Created by Jason on 14-12-26.
//
//
#warning DishCDModel 为 举列 名字。menuId productId 为DishCDModel中的数据。请自行修改
#import "DishCDService.h"

@implementation DishCDService

+ (NSMutableArray*)queryProducts{
    
    NSManagedObjectContext *context = [[CoreDataService defaultService] managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"DishCDModel"
                                              inManagedObjectContext:context];
    [request setEntity:entity];
    
    NSError *error;
    NSMutableArray *fetchResult = [[context executeFetchRequest:request
                                                          error:&error] mutableCopy];
    
    NSMutableArray *dishModelMutArr = [[NSMutableArray alloc]init];
    
    for (DishCDModel *dishCDModel in fetchResult) {
        [dishModelMutArr addObject:[self dishModelConvertByDishCDModel:dishCDModel]];
    }
    
    return dishModelMutArr;
}
+ (NSMutableArray*)queryDishsByMenuId:(int) menuId{
    
    NSManagedObjectContext *context = [[CoreDataService defaultService] managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"DishCDModel"
                                              inManagedObjectContext:context];
    [request setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"menuId = %@", [NSNumber numberWithInt:menuId]];
    [request setPredicate:predicate];
    NSError *error;
    NSMutableArray *fetchResult = [[context executeFetchRequest:request
                                                          error:&error] mutableCopy];
    
    NSMutableArray *dishModelMutArr = [[NSMutableArray alloc]init];
    
    for (DishCDModel *dishCDModel in fetchResult) {
        [dishModelMutArr addObject:[self dishModelConvertByDishCDModel:dishCDModel]];
    }
    
    return dishModelMutArr;
    
}

+ (void)insertDish:(NSDictionary *)dish
{
    NSManagedObjectContext *context = [[CoreDataService defaultService] managedObjectContext];
    DishCDModel *temp = [NSEntityDescription insertNewObjectForEntityForName:@"DishCDModel" inManagedObjectContext:context];
    temp = [self createDishCDModelByDic:dish DealDishCDM:temp];
    NSError *error;
    [context save:&error];
}

+ (void)deleteDishByProductId:(int) productId
{
    NSManagedObjectContext *context = [[CoreDataService defaultService] managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"DishCDModel"
                                              inManagedObjectContext:context];
    [request setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"productId = %d", productId];
    [request setPredicate:predicate];
    NSError *error;
    NSMutableArray *fetchResult = [[context executeFetchRequest:request
                                                          error:&error] mutableCopy];
    for (DishCDModel *dish in fetchResult) {
        [context deleteObject:dish];
        
        [context save:nil];
    }
}
+ (void)cleanDishs{
    NSManagedObjectContext *context = [[CoreDataService defaultService] managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"DishCDModel"
                                              inManagedObjectContext:context];
    [request setEntity:entity];
    
    NSError *error;
    NSMutableArray *fetchResult = [[context executeFetchRequest:request
                                                          error:&error] mutableCopy];
    for (DishCDModel *dish in fetchResult) {
        [context deleteObject:dish];
    }
    [context save:nil];
}

+ (void)updateDishByProductId:(NSDictionary *)dish{
    NSManagedObjectContext *context = [[CoreDataService defaultService] managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"DishCDModel"
                                              inManagedObjectContext:context];
    [request setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"productId = %d", [dish getIntValueForKey:@"productId" defaultValue:0]];
    [request setPredicate:predicate];
    NSError *error;
    NSMutableArray *fetchResult = [[context executeFetchRequest:request
                                                          error:&error] mutableCopy];
    if (fetchResult.count == 1) {
        for (DishCDModel *dishCDModel in fetchResult) {
              NSLog(@"coredata: 更新数据");
            [self createDishCDModelByDic:dish DealDishCDM:dishCDModel];
            
            NSError *error;
            [context save:&error];
        }
    }else if(fetchResult.count == 0 || fetchResult == nil){
        NSLog(@"coredata: 添加数据");
        [self insertDish:dish];
    }else{
        NSLog(@"更新的dishID 在coreData中不是唯一 id");
    }

}

/**
 *  将 CoreData 实体 DishCDModel 转成 普通对象
 *
 *  @param dishCDModel
 *
 *  @return
 */
+ (DishModel *)dishModelConvertByDishCDModel:(DishCDModel *)dishCDModel{
    
    DishModel *dishModel = [[DishModel alloc]init];
    dishModel.productId       = dishCDModel.productId;
    dishModel.menuId          = dishCDModel.menuId;
    
    dishModel.productName     = dishCDModel.productName;
    dishModel.shortDescr      = dishCDModel.shortDescr;
    dishModel.fullDescr       = dishCDModel.fullDescr;
    dishModel.unitName        = dishCDModel.unitName;
    
    if (dishCDModel.productNameLocale) {
        NSData *attributeData = [dishCDModel.productNameLocale dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error = [[NSError alloc]init];
        NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:attributeData options:NSJSONReadingAllowFragments error:&error];
        dishModel.productNameLocale      = jsonObject;
    }else{
        dishModel.productNameLocale      = nil;
    }
    
    if (dishCDModel.shortDescrLocale) {
        NSData *attributeData = [dishCDModel.shortDescrLocale dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error = [[NSError alloc]init];
        NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:attributeData options:NSJSONReadingAllowFragments error:&error];
        dishModel.shortDescrLocale      = jsonObject;
    }else{
        dishModel.shortDescrLocale      = nil;
    }
    
    if (dishCDModel.fullDescrLocale) {
        NSData *attributeData = [dishCDModel.fullDescrLocale dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error = [[NSError alloc]init];
        NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:attributeData options:NSJSONReadingAllowFragments error:&error];
        dishModel.fullDescrLocale      = jsonObject;
    }else{
        dishModel.fullDescrLocale      = nil;
    }
    
    if (dishCDModel.unitNameLocale) {
        NSData *attributeData = [dishCDModel.unitNameLocale dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error = [[NSError alloc]init];
        NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:attributeData options:NSJSONReadingAllowFragments error:&error];
        dishModel.unitNameLocale      = jsonObject;
    }else{
        dishModel.unitNameLocale      = nil;
    }
    
    dishModel.oldPrice        = dishCDModel.oldPrice;
    dishModel.price           =  dishCDModel.price;
    dishModel.sku             = dishCDModel.sku;
    dishModel.recommend       = dishCDModel.recommend;
    dishModel.sort            = dishCDModel.sort;
    
    if (dishCDModel.attributes) {
        NSData *attributeData = [dishCDModel.attributes dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error = [[NSError alloc]init];
        NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:attributeData options:NSJSONReadingAllowFragments error:&error];
        dishModel.attributes      = jsonObject;
    }else{
        dishModel.attributes      = nil;
    }
    
    if (dishCDModel.images) {
        NSData *attributeData = [dishCDModel.images dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error = [[NSError alloc]init];
        NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:attributeData options:NSJSONReadingAllowFragments error:&error];
        dishModel.images      = jsonObject;
    }else{
        dishModel.images      = nil;
    }
    
    if (dishCDModel.promotions) {
        NSData *attributeData = [dishCDModel.promotions dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error = [[NSError alloc]init];
        NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:attributeData options:NSJSONReadingAllowFragments error:&error];
        dishModel.promotions      = jsonObject;
    }else{
        dishModel.promotions      = nil;
    }
    
    return dishModel;
}

/**
 *  将 请求下来的 dic 转化成 dishCDModel 保存在 coreData 中
 *
 *  @param dishDic
 *  @param dishCDModel
 *
 *  @return
 */
+ (DishCDModel *)createDishCDModelByDic:(NSDictionary *)dishDic DealDishCDM:(DishCDModel *)dishCDModel{
    
    dishCDModel.productId       = [dishDic getIntNumberForKey:@"productId" defaultValue:0];
    dishCDModel.menuId          = [dishDic getIntNumberForKey:@"menuId" defaultValue:0];
    
    dishCDModel.productName     = [dishDic getStringValueForKey:@"productName" defaultValue:@""];
    dishCDModel.shortDescr      = [dishDic getStringValueForKey:@"shortDescr" defaultValue:@""];
    dishCDModel.fullDescr       = [dishDic getStringValueForKey:@"fullDescr" defaultValue:@""];
    dishCDModel.unitName        = [dishDic getStringValueForKey:@"unitName" defaultValue:@""];
    
     // 用nssting来保存json
    if ([dishDic objectForKey:@"productNameLocale"]) {
        NSData *strData = [NSJSONSerialization dataWithJSONObject:[dishDic objectForKey:@"productNameLocale"] options:NSJSONWritingPrettyPrinted error:nil];
        NSString *attributesStr = [[NSString alloc]initWithData:strData encoding:NSUTF8StringEncoding];
        dishCDModel.productNameLocale      = attributesStr;
    }else{
        dishCDModel.productNameLocale = @"";
    }
    
    if ([dishDic objectForKey:@"shortDescrLocale"]) {
        NSData *strData = [NSJSONSerialization dataWithJSONObject:[dishDic objectForKey:@"shortDescrLocale"] options:NSJSONWritingPrettyPrinted error:nil];
        NSString *attributesStr = [[NSString alloc]initWithData:strData encoding:NSUTF8StringEncoding];
        dishCDModel.shortDescrLocale      = attributesStr;
    }else{
        dishCDModel.shortDescrLocale = @"";
    }
    
    if ([dishDic objectForKey:@"fullDescrLocale"]) {
        NSData *strData = [NSJSONSerialization dataWithJSONObject:[dishDic objectForKey:@"fullDescrLocale"] options:NSJSONWritingPrettyPrinted error:nil];
        NSString *attributesStr = [[NSString alloc]initWithData:strData encoding:NSUTF8StringEncoding];
        dishCDModel.fullDescrLocale      = attributesStr;
    }else{
        dishCDModel.fullDescrLocale = @"";
    }
    
    if ([dishDic objectForKey:@"unitNameLocale"]) {
        NSData *strData = [NSJSONSerialization dataWithJSONObject:[dishDic objectForKey:@"unitNameLocale"] options:NSJSONWritingPrettyPrinted error:nil];
        NSString *attributesStr = [[NSString alloc]initWithData:strData encoding:NSUTF8StringEncoding];
        dishCDModel.unitNameLocale      = attributesStr;
    }else{
        dishCDModel.unitNameLocale = @"";
    }
    
    
    dishCDModel.oldPrice        = [dishDic getFloatNumberForKey:@"oldPrice" defaultValue:0];
    dishCDModel.price           = [dishDic getFloatNumberForKey:@"price" defaultValue:0];
    dishCDModel.sku             = [dishDic getIntNumberForKey:@"sku" defaultValue:0];
    dishCDModel.recommend       = [dishDic getBoolNumberForKey:@"recommend" defaultValue:NO];
    dishCDModel.sort            = [dishDic getIntNumberForKey:@"sort" defaultValue:0];
    
    // 用nssting来保存json
    if ([dishDic objectForKey:@"attributes"]) {
        NSData *strData = [NSJSONSerialization dataWithJSONObject:[dishDic objectForKey:@"attributes"] options:NSJSONWritingPrettyPrinted error:nil];
        NSString *attributesStr = [[NSString alloc]initWithData:strData encoding:NSUTF8StringEncoding];
        dishCDModel.attributes      = attributesStr;
    }else{
        dishCDModel.attributes = @"";
    }

    if ([dishDic objectForKey:@"images"]) {
        NSData *imgData = [NSJSONSerialization dataWithJSONObject:[dishDic objectForKey:@"images"] options:NSJSONWritingPrettyPrinted error:nil];
        NSString *imgStr = [[NSString alloc]initWithData:imgData encoding:NSUTF8StringEncoding];
           dishCDModel.images          = imgStr;
    }else{
        dishCDModel.images = @"";
    }
    
    if ([dishDic objectForKey:@"promotions"]) {
        NSData *imgData = [NSJSONSerialization dataWithJSONObject:[dishDic objectForKey:@"promotions"] options:NSJSONWritingPrettyPrinted error:nil];
        NSString *imgStr = [[NSString alloc]initWithData:imgData encoding:NSUTF8StringEncoding];
        dishCDModel.promotions          = imgStr;
    }else{
        dishCDModel.promotions = @"";
    }
    
    return dishCDModel;
}
@end
