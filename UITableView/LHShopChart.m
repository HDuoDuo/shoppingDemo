//
//  LHShopChart.m
//  UITableView
//
//  Created by liuhang on 16/9/12.
//  Copyright © 2016年 刘航. All rights reserved.
//

#import "LHShopChart.h"
#import "LHFoodCell.h"
#import "FoodModel.h"
#import <MagicalRecord/MagicalRecord.h>
static NSString * cellID = @"FoodCell";
@interface LHShopChart ()<UITableViewDelegate,UITableViewDataSource>
//foodTableView
@property (weak, nonatomic) IBOutlet UITableView *foodTableView;

@end

@implementation LHShopChart
//懒加载
- (NSMutableArray *)dataArray {
    if(_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化tableVeiw
    [self initTableView];
    //添加返回按钮
    UIBarButtonItem * leftbarButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(back)];
    [self.navigationItem setLeftBarButtonItem:leftbarButton];
    //编辑按钮
    UIBarButtonItem * rightbarButton = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(edit)];
    [self.navigationItem setRightBarButtonItem:rightbarButton];
    
}
- (void)edit
{
    NSLog(@"点了编辑按钮");
}
- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)initTableView
{
    //注册
    [self.foodTableView registerNib:[UINib nibWithNibName:NSStringFromClass([LHFoodCell class]) bundle:nil] forCellReuseIdentifier:cellID];
    self.foodTableView.rowHeight = 150;
    
    
}
#pragma mark ------------UITableViewDelegate,UITableViewDataSource-----
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LHFoodCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
//================================删除Cell=======================
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *deleteRoWAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {//title可自已定义
        NSLog(@"点击删除");
      FoodModel * model = self.dataArray[indexPath.row];
        [model MR_deleteEntity];
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        //移除
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
        //通过通知改变徽章的值
        [[NSNotificationCenter defaultCenter]postNotificationName:@"badge" object:nil];
    }];//此处是iOS8.0以后苹果最新推出的api，UITableViewRowAction，Style是划出的标签颜色等状态的定义，这里也可自行定义
    return @[deleteRoWAction];//最后返回这俩个RowAction 的数组
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
