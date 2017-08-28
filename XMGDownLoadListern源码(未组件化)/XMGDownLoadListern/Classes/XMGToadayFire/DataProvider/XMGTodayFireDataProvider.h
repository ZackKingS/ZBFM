//
//  XMGTodayFireDataProvider.h
//  XMGDownLoadListern
//
//  Created by 王顺子 on 16/11/29.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMGCategoryModel.h"
#import "XMGDownLoadVoiceModel.h"

@interface XMGTodayFireDataProvider : NSObject

+ (instancetype)shareInstance;

- (void)getTodayFireCategoryMs: (void(^)(NSArray <XMGCategoryModel *>*categoryMs))resultBlock;

- (void)getTodayFireVoiceMsWithKey: (NSString *)key result: (void(^)(NSArray <XMGDownLoadVoiceModel *>*voiceMs)) resultBlock;

@end
