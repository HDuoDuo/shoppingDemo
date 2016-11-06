//
//  LHDataModel.m
//  UITableView
//
//  Created by liuhang on 16/9/9.
//  Copyright © 2016年 刘航. All rights reserved.
//

#import "LHDataModel.h"
#import <FMDB.h>
#import "SqliteTool.h"
#import "BadgeView.h"
#pragma MARK --------------- LHDataModel
@implementation LHDataModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"items":[ItemsModel class]};
}
@end

#pragma MARK --------------- ItemsModel

@implementation ItemsModel
+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{@"ID":@"id",@"desc":@"description"};
}
//避免多次操作数据库,在使用较少的属性setter方法中操作数据库并对某个属性赋值
- (void)setID:(NSInteger)ID
{
    _ID = ID;
    FMDatabase * db = [SqliteTool shareCreateTable];
    //从数据库中读取
    BOOL isOpen = [db open];
    //打开数据库成功
    if (isOpen) {
        //查询数据库
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM isAdd"];
        while ([rs next]) {
            NSInteger Id = [rs intForColumn:@"ID"];
            NSInteger result = [rs intForColumn:@"isAddBus"];
            if (Id == ID && result) {
                _isAddBus = YES;
                return;
            }
        }
        //关闭数据库
        [db close];
    }else//打开数据库失败
    {
        NSLog(@"_db---%@",db.lastErrorMessage);
    }
}
//重写isAddBus  setter方法,对数据库进行操作
-(void)setIsAddBus:(BOOL)isAddBus
{
    //1.先对isAddBus赋值
    _isAddBus = isAddBus;
    /* 2. */
    FMDatabase * db = [SqliteTool shareCreateTable];
    //写入数据库中
    //打开数据库
    BOOL isOpen = [db open];
    //打开数据库成功
    if (isOpen) {
        if (isAddBus) {
            //1.插入数据数据库
            NSString * sqlStr = [NSString stringWithFormat:@"INSERT INTO 'isAdd' (ID,isAddBus) VALUES (%ld,%d);",self.ID,1];
            BOOL result =  [db executeUpdate:sqlStr];
            if (result) {
                NSLog(@"插入数据成功");
            }else
            {
                NSLog(@"_db---%@",db.lastErrorMessage);
            }
        }else//为no就删除数据
        {
            NSString * sqlStr0 = [NSString stringWithFormat:@"delete from isAdd where  ID = %ld;",self.ID];
           BOOL deleteResult =  [db executeUpdate:sqlStr0];
            if (deleteResult) {
                NSLog(@"删除数据成功");
            }else
            {
                NSLog(@"_db---%@",db.lastErrorMessage);
            }
        }
    }else//打开数据库失败
    {
        NSLog(@"_db---%@",db.lastErrorMessage);
    }
    //关闭数据库
    [db close];
}
@end


