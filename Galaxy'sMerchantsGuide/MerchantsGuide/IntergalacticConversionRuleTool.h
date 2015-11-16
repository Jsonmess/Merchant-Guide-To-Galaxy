//
//  IntergalacticConversionRule+RuleTool.h
//  Merchant's GuideDemo
//
//  Created by jsonmess on 15/11/15.
//  Copyright © 2015年 jsonmess. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  转换规则辅助工具类
 */
@interface IntergalacticConvaersionRuleTool : NSObject

/**
 *  将数拆分
 *
 *  @param number 数
 *
 *  @return 单个数字字母
 */
+(NSArray *)getFormNumberArray:(NSInteger)number;
/**
 *  检查是否是数字字符串
 *
 *  @param str 字符串
 *
 *  @return 输出
 */
+ (BOOL)checkIsTheAvailableNumberStr:(NSString *)str;
@end
