//
//  LHCoreDataTool.m
//  UITableView
//
//  Created by liuhang on 16/9/13.
//  Copyright © 2016年 刘航. All rights reserved.
//

#import "LHCoreDataTool.h"
#import <MagicalRecord/MagicalRecord.h>
#import "LHDataModel.h"
#import "FoodModel.h"
#import "BadgeView.h"

@implementation LHCoreDataTool
//添加/修改数据库
+ (void)recordOrChange:(id)anObject;
{
    [BadgeView shareInstance].badgeValue += 1;
    ItemsModel * model = (ItemsModel *)anObject;
    NSNumber * number = [NSNumber numberWithInteger:model.ID];
    //1.通过ID查询数据库中有没有
    NSArray * allIDs = [FoodModel MR_findByAttribute:@"iD" withValue:number];
    //2如果没有就添加
    if (allIDs.count == 0) {
        ////添加到数据库
        FoodModel * food = [FoodModel MR_createEntity];
        food.name = model.name;
        food.iD = number;
        NSArray * arr = [model.imgs componentsSeparatedByString:@","];
        food.imageUrl = arr[0];
        NSNumber * priceNum = [NSNumber numberWithInteger:model.finalPrice];
        food.price = priceNum;
        food.num = @1;
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    }else
    {
        //修改数据库中的信息
        FoodModel * findModel = allIDs[0];
        NSInteger number = [findModel.num integerValue];
        number += 1;
        NSNumber * num = [NSNumber numberWithInteger:number];
        findModel.num = num;
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    }
 
}
//取出数据库中的所有对象
+(NSArray *)fetchAllRecord
{
    return [FoodModel MR_findAll];
}

@end
