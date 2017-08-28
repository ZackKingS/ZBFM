//
//  XMGTodayFireDataProvider.m
//  XMGDownLoadListern
//
//  Created by 王顺子 on 16/11/29.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGTodayFireDataProvider.h"

#import "XMGSessionManager.h"
#import "MJExtension.h"
#import "XMGCategoryModel.h"



#define kBaseUrl @"http://mobile.ximalaya.com/"

@interface XMGTodayFireDataProvider ()

@property (nonatomic, strong) XMGSessionManager *sessionManager;

@end


@implementation XMGTodayFireDataProvider

static XMGTodayFireDataProvider *_shareInstance;
+ (instancetype)shareInstance {
    if (!_shareInstance) {
        _shareInstance = [[self alloc] init];
    }
    
    return _shareInstance;
}

- (XMGSessionManager *)sessionManager {
    if (!_sessionManager) {
        _sessionManager = [[XMGSessionManager alloc] init];
    }
    return _sessionManager;
}


- (void)getTodayFireCategoryMs: (void(^)(NSArray <XMGCategoryModel *>*categoryMs))resultBlock {

    NSString *url = [NSString stringWithFormat:@"%@%@", kBaseUrl, @"mobile/discovery/v2/rankingList/track"];
    NSDictionary *param = @{
                            @"device": @"iPhone",
                            @"key": @"ranking:track:scoreByTime:1:0",
                            @"pageId": @"1",
                            @"pageSize": @"0"
                            };

    [self.sessionManager request:RequestTypeGet urlStr:url parameter:param resultBlock:^(id responseObject, NSError *error) {


        XMGCategoryModel *categoryM = [[XMGCategoryModel alloc] init];
        categoryM.key = @"ranking:track:scoreByTime:1:0";
        categoryM.name = @"总榜";

        NSMutableArray <XMGCategoryModel *>*categoryMs = [XMGCategoryModel mj_objectArrayWithKeyValuesArray:responseObject[@"categories"]];
        if (categoryMs.count > 0) {
            [categoryMs insertObject:categoryM atIndex:0];
        }


        resultBlock(categoryMs);
        
    }];
}


- (void)getTodayFireVoiceMsWithKey: (NSString *)key result: (void(^)(NSArray <XMGDownLoadVoiceModel *>*voiceMs)) resultBlock {

    NSString *url = [NSString stringWithFormat:@"%@%@", kBaseUrl, @"mobile/discovery/v2/rankingList/track"];
    NSDictionary *param = @{
                            @"device": @"iPhone",
                            @"key": key,
                            @"pageId": @"1",
                            @"pageSize": @"30"
                            };

    [self.sessionManager request:RequestTypeGet urlStr:url parameter:param resultBlock:^(id responseObject, NSError *error) {


        NSMutableArray <XMGDownLoadVoiceModel *>*voiceyMs = [XMGDownLoadVoiceModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];

        resultBlock(voiceyMs);
        
    }];


}


@end
