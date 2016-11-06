//
//  LHShopButton.m
//  UITableView
//
//  Created by liuhang on 16/9/12.
//  Copyright © 2016年 刘航. All rights reserved.
//

#import "LHShopButton.h"

@implementation LHShopButton
{
    CGFloat _BtnWidth;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    _BtnWidth = rect.size.width;
    [self createUI];
}
/* 初始化购物车按钮 */
- (void)createUI
{
    //设置图片
    [self setBackgroundImage:[UIImage imageNamed:@"shopBtn"] forState:UIControlStateNormal];
    //设置圆角
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = _BtnWidth / 2.0;
    //监听点击事件
    [self addTarget:self action:@selector(shopBtnOnClicked) forControlEvents:UIControlEventTouchUpInside];
}
//点击事件的回调方法
- (void)shopBtnOnClicked
{
    if (self.shopTapped) {        
        self.shopTapped();
    }
}
@end
