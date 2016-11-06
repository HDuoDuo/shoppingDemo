//
//  SqliteTool.m
//  UITableView
//
//  Created by liuhang on 16/9/11.
//  Copyright © 2016年 刘航. All rights reserved.
//

#import "SqliteTool.h"

static FMDatabase * db = nil;

@implementation SqliteTool
+ (FMDatabase *)shareCreateTable
{
    if (db == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            //创建路径
            NSString * filePath = [NSHomeDirectory() stringByAppendingString:@"/Documents/tmp.db"];
            //创建数据库
            db = [FMDatabase databaseWithPath:filePath];
            if ([db open]) {
                NSString *sqlCreateTable =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS 'isAdd' ('ID' INTEGER PRIMARY KEY, 'isAddBus' INTEGER);"];
                BOOL res = [db executeUpdate:sqlCreateTable];
                if (!res) {
                    NSLog(@"error when creating db table");
                } else {
//                    NSLog(@"success to creating db table");
                }
                [db close];
            }
        });
    }
    return db;
}
@end
