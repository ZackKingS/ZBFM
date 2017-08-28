//
//  XMGDownLoadedVoicInAlbumTVC.m
//  XMGDownLoadListern
//
//  Created by 王顺子 on 16/11/25.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGDownLoadedVoicInAlbumTVC.h"


#import "XMGDownLoadListernDataTool.h"
#import "XMGDownLoadVoiceCellPresenter.h"
#import "XMGDownLoadVoiceCell.h"

@interface XMGDownLoadedVoicInAlbumTVC ()

@end

@implementation XMGDownLoadedVoicInAlbumTVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)reloadCache {

    NSArray <XMGDownLoadVoiceModel *>*downLoadingMs = [XMGDownLoadListernDataTool getDownLoadedVoiceMsInAlbumID:self.albumID];
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
