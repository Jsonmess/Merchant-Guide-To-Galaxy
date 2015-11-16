//
//  fileContentObject.h
//  Merchant's GuideDemo
//
//  Created by jsonmess on 15/11/16.
//  Copyright © 2015年 jsonmess. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  文件读取和解析
 */
@interface fileContentObject : NSObject

//用户自定义映射关系
@property (nonatomic,strong)NSMutableDictionary *userMappingDic;

//文件读取后的输出结果
@property (nonatomic,strong)NSString *resultStr;
/**
 *  解析长句子
 *
 *  @param sentence 句子
 */
-(void)AnalysisTheDescribeSentence:(NSString*)sentence;

@end
