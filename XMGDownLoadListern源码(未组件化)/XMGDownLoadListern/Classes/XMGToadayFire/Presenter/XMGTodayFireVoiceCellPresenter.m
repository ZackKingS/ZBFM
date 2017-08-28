//
//  XMGTodayFireVoiceCellPresenter.m
//  XMGDownLoadListern
//
//  Created by 王顺子 on 16/11/29.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGTodayFireVoiceCellPresenter.h"
#import "UIButton+WebCache.h"
#import "XMGDownLoadManager.h"
#import "XMGRemotePlayer.h"

#import "XMGSqliteModelTool.h"

@interface XMGTodayFireVoiceCellPresenter ()

@property (nonatomic, weak) XMGTodayFireVoiceCell *cell;

@end


@implementation XMGTodayFireVoiceCellPresenter

- (NSString *)title {
    return self.voiceM.title;
}

- (NSString *)authorName {
    return [NSString stringWithFormat:@"by %@", self.voiceM.nickname];
}

- (NSURL *)voiceURL {
    return [NSURL URLWithString:self.voiceM.coverSmall];
}

- (NSString *)sortNumStr {
    return [NSString stringWithFormat:@"%zd", self.sortNum];
}

- (NSURL *)playOrDownLoadURL {
    return [NSURL URLWithString:self.voiceM.playPathAacv164];
}

- (XMGTodayFireVoiceCellState)cellDownLoadState {
    XMGDownLoader *downLoaer = [[XMGDownLoadManager shareInstance] getDownLoaderWithURL:[self playOrDownLoadURL]];
    if (downLoaer.state == XMGDownLoaderStateDowning) {
        return  XMGTodayFireVoiceCellStateDownLoading;
    }else if (downLoaer.state == XMGDownLoaderStateSuccess  || [XMGDownLoader downLoadedFileWithURL:[self playOrDownLoadURL]].length > 0) {
        return   XMGTodayFireVoiceCellStateDownLoaded;
    }else {
        return  XMGTodayFireVoiceCellStateWaitDownLoad;
    }

}

- (BOOL)isPlaying {
    if ([[self playOrDownLoadURL] isEqual:[XMGRemotePlayer shareInstance].url]) {

        XMGRemotePlayerState state = [XMGRemotePlayer shareInstance].state;
        if (state == XMGRemotePlayerStatePlaying) {
            return YES;
        }else {
            return NO;
        }
    }else {
        return NO;
    }
}


- (void)bindWithCell: (XMGTodayFireVoiceCell *)cell {

    self.cell = cell;

    cell.voiceTitleLabel.text = [self title];
    cell.voiceAuthorLabel.text = [self authorName];
    [cell.playOrPauseBtn sd_setBackgroundImageWithURL:[self voiceURL]  forState:UIControlStateNormal];
    cell.sortNumLabel.text = [self sortNumStr];

    // 动态计算下载状态
    cell.state = [self cellDownLoadState];
    // 动态计算播放状态
    cell.playOrPauseBtn.selected = [self isPlaying];



    // 事件处理
    [cell setPlayBlock:^(BOOL isPlay) {
        if (isPlay) {
            [[XMGRemotePlayer shareInstance] playWithURL:[self playOrDownLoadURL]];
        }else {
            [[XMGRemotePlayer shareInstance] pause];
        }
    }];

    __weak typeof(self) weakSelf = self;
    [cell setDownLoadBlock:^{

        __strong typeof(weakSelf.voiceM) strongVoiceM = weakSelf.voiceM;
        [[XMGDownLoadManager shareInstance] downLoadWithURL:[self playOrDownLoadURL] downLoadInfo:^(long long fileSize) {
            strongVoiceM.totalSize = fileSize;
            [XMGSqliteModelTool saveModel:strongVoiceM uid:nil];
        } success:^(NSString *cacheFilePath) {
            strongVoiceM.isDownLoaded = YES;
            [XMGSqliteModelTool saveModel:strongVoiceM uid:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadCache" object:nil];
        } failed:nil];
    }];

}


- (void)downLoadStateChange: (NSNotification *)notice {

    self.cell.state = [self cellDownLoadState];
}


- (void)playStateChange: (NSNotification *)notice {
    NSDictionary *noticeDic = notice.userInfo;
    NSURL *url = noticeDic[@"playURL"];
    XMGRemotePlayerState state = [noticeDic[@"playState"] integerValue];

    if ([[self playOrDownLoadURL] isEqual:url]) {
        if (state == XMGRemotePlayerStatePlaying) {
            self.cell.playOrPauseBtn.selected = YES;
        }else {
            self.cell.playOrPauseBtn.selected = NO;
        }
    }else {
        self.cell.playOrPauseBtn.selected = NO;
    }

}


- (instancetype)init{
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downLoadStateChange:) name:kDownLoadURLOrStateChangeNotification object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playStateChange:) name:kRemotePlayerURLOrStateChangeNotification object:nil];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"SHIFANGLE--%@", self.voiceM.title);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
