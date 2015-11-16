//
//  IntergalacticConversionRule.h
//  Merchant's GuideDemo
//
//  Created by jsonmess on 15/11/14.
//  Copyright © 2015年 jsonmess. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IntergalacticSymbol.h"
//星际数字与阿拉伯数字转换
@interface IntergalacticConversionRule : NSObject

/**
 *  提供阿拉伯数字-->星际数字转换
 *
 *  @param ArabicNumber 阿拉伯数字
 *
 *  @return 星际数字
 */
-(NSString *)getRomanNumberWithArabicNumber:(NSInteger)arabicNumber;

/**
 *  提供星际数字-->阿拉伯数字转换
 *
 *  @param ArabicNumber 星际数字
 *
 *  @return 阿拉伯数字
 */
-(NSInteger)getArabicNumberWithRomanNumber:(NSString*)romanNumber;



@end
