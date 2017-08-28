//
//  XMGDownLoadVoiceCellPresenter.h
//  XMGDownLoadListern
//
//  Created by 王顺子 on 16/11/29.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMGDownLoadVoiceModel.h"
#import "XMGDownLoadVoiceCell.h"

@interface XMGDownLoadVoiceCellPresenter : NSObject

// 原始数据
@property (nonatomic, strong) XMGDownLoadVoiceModel *voiceM;



- (void)bindWithCell: (XMGDownLoadVoiceCell *)cell;

@end
