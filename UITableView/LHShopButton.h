//
//  LHShopButton.h
//  UITableView
//
//  Created by liuhang on 16/9/12.
//  Copyright © 2016年 刘航. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^shopButtonBlock)();
@interface LHShopButton : UIButton
/* 购物按钮的点击回调 */
@property (nonatomic,copy) shopButtonBlock shopTapped;
@end
