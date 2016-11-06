//
//  BadgeView.m
//  ZFShoppingCart
//
//  Created by macOne on 15/11/6.
//  Copyright © 2015年 WZF. All rights reserved.
//

#import "BadgeView.h"

@interface BadgeView ()
@property (nonatomic,strong) UILabel *textLabel;
@property (nonatomic,strong) UIColor * color;
@end

@implementation BadgeView
//懒加载
- (UIColor *)color {
    if(_color == nil) {
        _color = [[UIColor alloc] init];
        _color = [UIColor whiteColor];
    }
    return _color;
}
/* 单例方法 */
+(BadgeView *)shareInstance
{
    static BadgeView * badge = nil;
    static dispatch_once_t onceToken;
    if (badge == nil) {
        dispatch_once(&onceToken, ^{
            badge = [[BadgeView alloc]init];
        });
    }
    return badge;
}
/* 设置徽章 */
-(void)setFrame:(CGRect)frame withNumber:(NSInteger)number
{
    [super setFrame:frame];
    self.backgroundColor = [UIColor redColor];
    self.layer.cornerRadius = frame.size.height /2;
    self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    self.textLabel.font = [UIFont systemFontOfSize:13.0f];
    self.textLabel.textColor = _color;
    self.textLabel.text = [NSString stringWithFormat:@"%ld",number];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.textLabel];
    self.badgeValue = number;
}
//设置frame和颜色
-(void)setFrame:(CGRect)frame withNumber:(NSInteger)number TextColor:(UIColor *)textColor
{
    self.color = textColor;
    [self setFrame:frame withNumber:number];
}
//设置显示徽章
-(void)setBadgeValue:(NSInteger) badgeValue
{
    _badgeValue = badgeValue;
    if ((badgeValue <= 0) || !badgeValue) {
        self.hidden = YES;
    }
    else{
        NSString * str = [NSString stringWithFormat:@"%ld",badgeValue];
        if (badgeValue > 99) {
            str  = @"...";
        }
        self.textLabel.text = str;
        self.hidden = NO;
    }
}

@end
