//
//  XMGDownLoadAlbumTVC.m
//  XMGDownLoadListern
//
//  Created by 王顺子 on 16/11/29.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGDownLoadAlbumTVC.h"

#import "XMGDownLoadListernDataTool.h"
#import "XMGDownLoadAlbumCellPresenter.h"
#import "XMGDownLoadAlbumCell.h"

@interface XMGDownLoadAlbumTVC ()

@end

@implementation XMGDownLoadAlbumTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)reloadCache {

    NSArray <XMGAlbumModel *>*albumMs = [XMGDownLoadListernDataTool getDownLoadedAlbums];
    NSMutableArray <XMGDownLoadAlbumCellPresenter *>*presenters = [NSMutableArray arrayWithCapacity:albumMs.count];
    for (XMGAlbumModel *albumM in albumMs) {
        XMGDownLoadAlbumCellPresenter *presenter = [XMGDownLoadAlbumCellPresenter new];
        presenter.albumModel = albumM;
        [presenters addObject:presenter];
    }



    [self setUpWithDataSouce:presenters getCell:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
        return [XMGDownLoadAlbumCell cellWithTableView:tableView];
    } cellHeight:^CGFloat(id model) {
        return 80;
    } bind:^(XMGDownLoadAlbumCell *cell, XMGDownLoadAlbumCellPresenter *model) {
        [model bindWithCell:cell];
    }];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reloadCache];
}


@end
