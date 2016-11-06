//
//  LHCoreDataTool.h
//  UITableView
//
//  Created by liuhang on 16/9/13.
//  Copyright © 2016年 刘航. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHCoreDataTool : NSObject
//添加对象并且存入数据库
+ (void)recordOrChange:(id)anObject;
//移除对象并从数据库中移除
+(NSArray *)fetchAllRecord;
@end
