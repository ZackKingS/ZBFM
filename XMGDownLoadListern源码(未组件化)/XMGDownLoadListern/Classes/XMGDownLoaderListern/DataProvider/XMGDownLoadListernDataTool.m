//
//  XMGDownLoadListernDataTool.m
//  XMGDownLoadListern
//
//  Created by 王顺子 on 16/11/23.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGDownLoadListernDataTool.h"
#import "XMGSqliteModelTool.h"

@implementation XMGDownLoadListernDataTool

+ (NSArray <XMGDownLoadVoiceModel *>*)getDownLoadingVoiceMs {

    return [XMGSqliteModelTool queryModels:[XMGDownLoadVoiceModel class]  key:@"isDownLoaded" relation:XMGSqliteModelToolRelationTypeEqual value:@(NO) uid:nil];

}

+ (NSArray <XMGDownLoadVoiceModel *>*)getDownLoadedVoiceMs {
   return [XMGSqliteModelTool queryModels:[XMGDownLoadVoiceModel class]  key:@"isDownLoaded" relation:XMGSqliteModelToolRelationTypeEqual value:@(YES) uid:nil];
}

+ (NSArray <XMGDownLoadVoiceModel *>*)getDownLoadedVoiceMsInAlbumID: (NSInteger)albumID {

    return [XMGSqliteModelTool queryModels:[XMGDownLoadVoiceModel class] keys:@[@"isDownLoaded", @"albumID"] relations:@[@(XMGSqliteModelToolRelationTypeEqual), @(XMGSqliteModelToolRelationTypeEqual)] values:@[@"1", @(albumID)] nao:@[@(XMGSqliteModelToolNAOAnd)] uid:nil];

}

+ (NSArray <XMGDownLoadVoiceModel *>*)getDownLoadedAlbums {



    NSArray *array = [XMGSqliteModelTool queryModels:[XMGAlbumModel class] sql:@"select albumId, albumTitle, commentsCounts, coverSmall as albumCoverMiddle,nickName as authorName, count(*) as voiceCount, sum(totalSize) as allVoiceSize from XMGDownLoadVoiceModel where isDownLoaded = '1' group by albumId" uid:nil];

    return array;
}


@end
