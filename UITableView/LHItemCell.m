//
//  LHItemCell.m
//  UITableView
//
//  Created by liuhang on 16/9/9.
//  Copyright © 2016年 刘航. All rights reserved.
//

#import "LHItemCell.h"
#import <UIImageView+WebCache.h>
#import "LHShopButton.h"
#import "LHShopChart.h"
#import "LHCoreDataTool.h"
@interface LHItemCell ()
/* 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *itemImg;
/* 描述 */
@property (weak, nonatomic) IBOutlet UILabel *itemDesc;
 /* 价格 */
@property (weak, nonatomic) IBOutlet UILabel *itemPrice;
/* 添加购物车按钮 */
@property (weak, nonatomic) IBOutlet UIButton *addBus;
/* 购物按钮*/
@property (weak, nonatomic) IBOutlet LHShopButton *shopBtn;
@end
@implementation LHItemCell

-(void)setModel:(ItemsModel *)model
{
    _model = model;
    //图片加载
    [_itemImg sd_setImageWithURL:[NSURL URLWithString:[self componentStringFromImgs:model.imgs]]];
    //name
    _itemDesc.text = model.name;
    //price
    _itemPrice.text = [NSString stringWithFormat:@"￥%ld/%@",model.finalPrice,model.specification];
    //这里应该先从数据库中获取,数据中没有再从服务器中获取
    _addBus.selected = model.isAddBus;
}
//分割图片地址数据
- (NSString *)componentStringFromImgs:(NSString *)str
{
    NSArray * arr = [str componentsSeparatedByString:@","];
    return arr[0];
}
//---------------------------购物车数据源----------------
- (void)awakeFromNib {
    __weak typeof(self) weakSelf = self;
     //购物按钮的点击实现
        self.shopBtn.shopTapped = ^(){
            //将数据模型添加至数组
            [LHCoreDataTool recordOrChange:weakSelf.model];
        };
}
//更改按钮的状态
- (IBAction)itemAddBus:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.model.isAddBus = sender.selected;
    //在模型中重写Set方法,进行数据库存储
}
//重写选中方法
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        //改变字体颜色
        self.itemDesc.textColor = [UIColor redColor];
    }else
    {
        self.itemDesc.textColor = [UIColor blackColor];

    }
}
@end
