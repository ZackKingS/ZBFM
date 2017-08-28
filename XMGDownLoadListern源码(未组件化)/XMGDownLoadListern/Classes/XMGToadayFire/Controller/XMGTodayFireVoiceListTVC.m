//
//  XMGTodayFireVoiceListTVC.m
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/21.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGTodayFireVoiceListTVC.h"

// 数据的提供者(数据模型)
#import "XMGTodayFireDataProvider.h"

// 数据模型如何具体展示在视图上
#import "XMGTodayFireVoiceCellPresenter.h"

// 视图
#import "XMGTodayFireVoiceCell.h"


@interface XMGTodayFireVoiceListTVC ()

@property (nonatomic, strong) NSArray<XMGTodayFireVoiceCellPresenter *> *presenterMs;

@end

@implementation XMGTodayFireVoiceListTVC


- (void)setPresenterMs:(NSArray<XMGTodayFireVoiceCellPresenter *> *)presenterMs {
    _presenterMs = presenterMs;
    [self.tableView reloadData];
}


-(void)viewDidLoad
{
    self.tableView.rowHeight = 80;
    __weak typeof(self) weakSelf = self;
    [[XMGTodayFireDataProvider shareInstance] getTodayFireVoiceMsWithKey:self.loadKey result:^(NSArray<XMGDownLoadVoiceModel *> *voiceMs) {

        NSMutableArray *presenters = [NSMutableArray array];
        for (XMGDownLoadVoiceModel *voiceM in voiceMs) {
            XMGTodayFireVoiceCellPresenter *presenter = [[XMGTodayFireVoiceCellPresenter alloc] init];
            presenter.voiceM = voiceM;
            [presenters addObject:presenter];
        }

        weakSelf.presenterMs = presenters;
    }];

}




#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.presenterMs.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    XMGTodayFireVoiceCell *cell = [XMGTodayFireVoiceCell cellWithTableView:tableView];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    XMGTodayFireVoiceCellPresenter *presenter = self.presenterMs[indexPath.row];

    NSLog(@"跳转到播放器界面进行播放--%@--", presenter.voiceM.title);

}

- (void)tableView:(UITableView *)tableView willDisplayCell:(nonnull XMGTodayFireVoiceCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {

    XMGTodayFireVoiceCellPresenter *presenter = self.presenterMs[indexPath.row];
    presenter.sortNum = indexPath.row + 1;
    [presenter bindWithCell:cell];
}



@end
