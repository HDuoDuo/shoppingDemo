//
//  BadgeView.h
//  ZFShoppingCart
//
//  Created by macOne on 15/11/6.
//  Copyright © 2015年 WZF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BadgeView : UIView
/* 徽章数字 */
@property (nonatomic,assign) NSInteger badgeValue;
/* 设置徽章 */
-(void)setFrame:(CGRect)frame withNumber:(NSInteger)number;
//设置frame和颜色
-(void)setFrame:(CGRect)frame withNumber:(NSInteger)number TextColor:(UIColor *)textColor;
/* 单例 */
+ (BadgeView *)shareInstance;
@end
