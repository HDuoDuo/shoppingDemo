//
//  SqliteTool.h
//  UITableView
//
//  Created by liuhang on 16/9/11.
//  Copyright © 2016年 刘航. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>
@interface SqliteTool : NSObject
+ (FMDatabase *)shareCreateTable;
@end
