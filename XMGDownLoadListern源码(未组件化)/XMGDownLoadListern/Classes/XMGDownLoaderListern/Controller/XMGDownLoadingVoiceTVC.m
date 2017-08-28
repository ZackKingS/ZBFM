//
//  XMGDownLoadingVoiceTVC.m
//  XMGDownLoadListern
//
//  Created by 王顺子 on 16/11/29.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGDownLoadingVoiceTVC.h"

#import "XMGDownLoadListernDataTool.h"
#import "XMGDownLoadVoiceCellPresenter.h"
#import "XMGDownLoadVoiceCell.h"


@interface XMGDownLoadingVoiceTVC ()

@end

@implementation XMGDownLoadingVoiceTVC

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)reloadCache {

    NSArray <XMGDownLoadVoiceModel *>*downLoadingMs = [XMGDownLoadListernDataTool getDownLoadingVoiceMs];
    NSMutableArray <XMGDownLoadVoiceCellPresenter *>*downLoadingPresenters = [NSMutableArray arrayWithCapacity:downLoadingMs.count];
    for (XMGDownLoadVoiceModel *downLoadingM in downLoadingMs) {
        XMGDownLoadVoiceCellPresenter *presenter = [XMGDownLoadVoiceCellPresenter new];
        presenter.voiceM = downLoadingM;
        [downLoadingPresenters addObject:presenter];
    }


    [self setUpWithDataSouce:downLoadingPresenters getCell:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
        return [XMGDownLoadVoiceCell cellWithTableView:tableView];
    } cellHeight:^CGFloat(id model) {
        return 110;
    } bind:^(XMGDownLoadVoiceCell *cell, XMGDownLoadVoiceCellPresenter *model) {
        [model bindWithCell:cell];
    }];


}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reloadCache];
}



@end
