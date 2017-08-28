//
//  XMGDownLoadBaseTVC.m
//  XMGDownLoadListern
//
//  Created by 王顺子 on 16/11/29.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGDownLoadBaseTVC.h"
#import "XMGNoDownLoadView.h"
#import "XMGTodayFireMainVC.h"

@interface XMGDownLoadBaseTVC ()

@property (nonatomic, strong) NSArray *dataSources;

@property (nonatomic, weak) XMGNoDownLoadView *noDataLoadView;

@property (nonatomic, copy) GetCellBlock cellBlock;
@property (nonatomic, copy) GetHeightBlock heightBlock;
@property (nonatomic, copy) BindBlock bindBlock;

@end

@implementation XMGDownLoadBaseTVC

#pragma mark - 懒加载

- (XMGNoDownLoadView *)noDataLoadView {
    if (!_noDataLoadView) {
        XMGNoDownLoadView *noLoadView = [XMGNoDownLoadView noDownLoadView];
        [self.view addSubview:noLoadView];
        _noDataLoadView = noLoadView;
    }
    return _noDataLoadView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [UIView new];
    self.noDataLoadView.center = CGPointMake(self.view.frame.size.width * 0.5, self.view.frame.size.height * 0.4);
    
    if ([self isKindOfClass:NSClassFromString(@"XMGDownLoadingVoiceTVC")]) {
        self.noDataLoadView.noDataImg = [UIImage imageNamed:@"noData_downloading"];
    }else {
        self.noDataLoadView.noDataImg = [UIImage imageNamed:@"noData_download"];
    }

    [self.noDataLoadView setClickBlock:^{
//        NSLog(@"去看看");
        XMGTodayFireMainVC *todayFire = [[XMGTodayFireMainVC alloc] init];
        [self.navigationController pushViewController:todayFire animated:YES];
    }];

    // 数据源
    // cell
    // 高度
    // bind

    // 监听重新加载数据的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadCache) name:@"reloadCache" object:nil];

}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)reloadCache {
    NSLog(@"等待被重写");
}

- (void)setUpWithDataSouce: (NSArray *)dataSource getCell: (GetCellBlock)cellBlock cellHeight: (GetHeightBlock)cellHeightBlock bind: (BindBlock)bindBlock
{

    self.dataSources = dataSource;
    self.cellBlock = cellBlock;
    self.heightBlock = cellHeightBlock;
    self.bindBlock = bindBlock;

    [self.tableView reloadData];


}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    self.noDataLoadView.hidden = self.dataSources.count != 0;
    return self.dataSources.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = self.cellBlock(tableView, indexPath);

    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    id model = self.dataSources[indexPath.row];
    self.bindBlock(cell, model);
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id model = self.dataSources[indexPath.row];
    if (self.heightBlock) {
        return  self.heightBlock(model);
    }
    return 44;
}

@end
