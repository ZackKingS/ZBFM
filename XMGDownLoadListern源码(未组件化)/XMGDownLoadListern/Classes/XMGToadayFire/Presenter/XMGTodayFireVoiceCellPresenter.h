//
//  XMGTodayFireVoiceCellPresenter.h
//  XMGDownLoadListern
//
//  Created by 王顺子 on 16/11/29.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMGDownLoadVoiceModel.h"
#import "XMGTodayFireVoiceCell.h"

@interface XMGTodayFireVoiceCellPresenter : NSObject

@property (nonatomic, strong) XMGDownLoadVoiceModel *voiceM;

@property (nonatomic, assign) NSInteger sortNum;

- (void)bindWithCell: (XMGTodayFireVoiceCell *)cell;

@end
