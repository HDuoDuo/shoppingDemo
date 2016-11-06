//
//  ViewController.m
//  UITableView
//
//  Created by liuhang on 16/9/8.
//  Copyright © 2016年 刘航. All rights reserved.
//
#import "ViewController.h"
#import <AFNetworking.h>
#import <YYModel.h>
#import "LHDataModel.h"
#import "LHItemCell.h"
#import <SVProgressHUD.h>
#import <MJRefresh.h>
#import "LHShopChart.h"
#import "BadgeView.h"
#import <Masonry.h>
#import "LHCoreDataTool.h"
#import <MagicalRecord/MagicalRecord.h>
#import "FoodModel.h"
static NSString * itemCell  = @"itemCell";
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
/* 数据请求对象 */
@property (nonatomic,strong) AFHTTPSessionManager * httpManager;
/* 数据源数组 */
@property (nonatomic,strong) NSMutableArray * dataArray;
/* tabelView */
@property (weak, nonatomic) IBOutlet UITableView *itemTableView;
/* 记录当前加载数据的总数 */
@property (nonatomic,assign) NSInteger pageCount;
/* 数据模型 */
@property (nonatomic,strong) LHDataModel * dataModel;
@property (weak, nonatomic) IBOutlet UIButton *shopBtn;
@end

@implementation ViewController
/* 懒加载 */
- (AFHTTPSessionManager *)httpManager {
    if(_httpManager == nil) {
        _httpManager = [[AFHTTPSessionManager alloc] init];
        _httpManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/x-gzip",@"application/json", nil];
    }
    return _httpManager;
}
/* 数据源数组 */
- (NSMutableArray *)dataArray {
    if(_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    /*  请求数据*/
    [self loadData];
    [SVProgressHUD showWithStatus:@"正在加载中"];
    /* 初始化tableView */
    [self initTableView];
    //设置徽章
    [self setupBadge];
}
- (void)setupBadge
{
    [[BadgeView shareInstance] setFrame:CGRectMake(0, 0, 20, 20) withNumber:0 TextColor:[UIColor whiteColor]];
    [self.view addSubview:[BadgeView shareInstance]];
    [[BadgeView shareInstance] mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).offset(210);
        make.bottom.equalTo(self.view).offset(-13);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    [self setupTheBadge];
    //监听通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setupTheBadge) name:@"badge" object:nil];
}
- (void)setupTheBadge
{
    [BadgeView shareInstance].badgeValue = 0;
    //设置number
    NSArray *arr = [FoodModel MR_findAll];
    for (FoodModel *model in arr) {
        NSInteger number = [model.num integerValue];
        [BadgeView shareInstance].badgeValue += number;
    }
}
//初始化tableView
- (void)initTableView
{
    [self.itemTableView registerNib:[UINib nibWithNibName:@"LHItemCell" bundle:nil] forCellReuseIdentifier:itemCell];
    self.itemTableView.rowHeight = 135;
    //上拉加载
    __weak typeof(self) weakSelf = self;
    //设置下拉刷新
    self.itemTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    //设置上拉加载
    self.itemTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //调用方法加载
        [weakSelf loadMoreData];        
    }];
}
//刷新数据
- (void)loadData
{
    self.pageCount = 0;
    //请求地址
    NSString * requestStr = [NSString stringWithFormat:@"http://api.sunyuki.com/v0/items?cateId=115&limit=10&offset=%ld",self.pageCount];
    [self requestDataWithStr:requestStr];
}
//加载更多数据
- (void)loadMoreData
{
    if (self.pageCount < self.dataModel.totalSize) {
        //请求地址
        NSString * requestStr = [NSString stringWithFormat:@"http://api.sunyuki.com/v0/items?cateId=115&limit=10&offset=%ld",self.pageCount];
        [self requestDataWithStr:requestStr];
    }else
    {
        [self.itemTableView.mj_footer endRefreshingWithNoMoreData];
    }
    
}
//请求数据
- (void)requestDataWithStr:(NSString *)str
{
    //请求数据
    __weak typeof(self) weakSelf = self;
    [self.httpManager GET:str parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"数据请求成功");
        [SVProgressHUD dismiss];
        //解析数据
        weakSelf.dataModel = [LHDataModel yy_modelWithJSON:responseObject];
        if (weakSelf.pageCount == 0) {
            //清空数据源
            [weakSelf.dataArray removeAllObjects];
        }
        //遍历model中的表格数据
        for (ItemsModel * itemModel in weakSelf.dataModel.items) {
            [weakSelf.dataArray addObject:itemModel];
        }
        //保存请求位置
        weakSelf.pageCount = weakSelf.dataModel.limit + weakSelf.dataModel.startIndex;
        //刷新数据
        [weakSelf.itemTableView reloadData];
        //结束Refresh
        [weakSelf.itemTableView.mj_header endRefreshing];
        [weakSelf.itemTableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"数据请求失败 -- %@",error);

    }];
}
#pragma mark --UITableViewDelegate,UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LHItemCell * cell = [tableView dequeueReusableCellWithIdentifier:itemCell forIndexPath:indexPath];
    //在下面方法中添加
    cell.showsReorderControl =YES;
    ItemsModel * model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
#pragma mark -- 对cell进行删除操作
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
//进入编辑模式，点击出现的编辑按钮后,结束编辑
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView setEditing:NO animated:YES];
}
-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *deleteRoWAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {//title可自已定义
        NSLog(@"点击删除");
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    }];//此处是iOS8.0以后苹果最新推出的api，UITableViewRowAction，Style是划出的标签颜色等状态的定义，这里也可自行定义
    UITableViewRowAction *editRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"编辑" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"点击编辑");
    }];
    editRowAction.backgroundColor = [UIColor colorWithRed:0 green:124/255.0 blue:223/255.0 alpha:1];//可以定义RowAction的颜色
    return @[deleteRoWAction, editRowAction];//最后返回这俩个RowAction 的数组
}
//modal出购物车控制器
- (IBAction)shopButton:(UIButton *)sender {
    LHShopChart * shop = [[LHShopChart alloc]init];
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:shop];
    shop.dataArray = [NSMutableArray arrayWithArray:[LHCoreDataTool fetchAllRecord]];
    [self presentViewController:nav animated:YES completion:nil];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
