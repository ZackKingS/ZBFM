//
//  XMGDownLoadVoiceTVC.m
//  XMGDownLoadListern
//
//  Created by 王顺子 on 16/11/29.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGDownLoadVoiceTVC.h"

#import "XMGDownLoadListernDataTool.h"
#import "XMGDownLoadVoiceCellPresenter.h"
#import "XMGDownLoadVoiceCell.h"

@interface XMGDownLoadVoiceTVC ()

@end

@implementation XMGDownLoadVoiceTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)reloadCache {

    NSArray <XMGDownLoadVoiceModel *>*downLoadingMs = [XMGDownLoadListernDataTool getDownLoadedVoiceMs];
    NSMutableArray <XMGDownLoadVoiceCellPresenter *>*downLoadingPresenters = [NSMutableArray arrayWithCapacity:downLoadingMs.count];
    for (XMGDownLoadVoiceModel *downLoadingM in downLoadingMs) {
        XMGDownLoadVoiceCellPresenter *presenter = [XMGDownLoadVoiceCellPresenter new];
        presenter.voiceM = downLoadingM;
        [downLoadingPresenters addObject:presenter];
    }


    [self setUpWithDataSouce:downLoadingPresenters getCell:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
        return [XMGDownLoadVoiceCell cellWithTableView:tableView];
    } cellHeight:^CGFloat(id model) {
        return 80;
    } bind:^(XMGDownLoadVoiceCell *cell, XMGDownLoadVoiceCellPresenter *model) {
        [model bindWithCell:cell];
    }];


}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reloadCache];
}

@end
