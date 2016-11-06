
//
//  LHFoodCell.m
//  UITableView
//
//  Created by liuhang on 16/9/13.
//  Copyright © 2016年 刘航. All rights reserved.
//

#import "LHFoodCell.h"
#import <PPNumberButton.h>
#import <UIImageView+WebCache.h>
#import <MagicalRecord/MagicalRecord.h>
#import "BadgeView.h"
@interface LHFoodCell ()
/* 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *foodImg;
/* 名称 */
@property (weak, nonatomic) IBOutlet UILabel *nameLB;
/* 价格 */
@property (weak, nonatomic) IBOutlet UILabel *priceLB;
/* 数量 */
@property (weak, nonatomic) IBOutlet PPNumberButton *numBtn;

@end
@implementation LHFoodCell

- (void)awakeFromNib {
    // numBtn的设置
    _numBtn.numberBlock = ^(NSString * number){
        NSInteger num = [number integerValue];
        _model.num = [NSNumber numberWithInteger:num];
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        //通过通知改变徽章的值
        [[NSNotificationCenter defaultCenter]postNotificationName:@"badge" object:nil];
    };
    
}
-(void)setModel:(FoodModel *)model
{
    _model = model;
    [_foodImg sd_setImageWithURL:[NSURL URLWithString:_model.imageUrl]];
    _nameLB.text = _model.name;
    NSInteger price = [_model.price integerValue];
    _priceLB.text = [NSString stringWithFormat:@"￥%ld",price];
    //
    NSInteger num = [_model.num integerValue];
    _numBtn.currentNumber = [NSString stringWithFormat:@"%ld",num];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
@end
