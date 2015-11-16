//
//  IntergalacticSymbol.h
//  Merchant's GuideDemo
//
//  Created by jsonmess on 15/11/14.
//  Copyright © 2015年 jsonmess. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  用于星际转换（阿拉伯数字<-->罗马字符）
 */
@interface IntergalacticSymbol : NSObject

/**
 *  提供阿拉伯字符-->罗马字符转换
 *
 *  @param ArabicNumber 阿拉伯字符
 *
 *  @return 罗马字符
 */
-(NSString *)getRomanSymbolWithArabicSymbol:(NSInteger)ArabicSymbol;

/**
 *  提供罗马字符-->阿拉伯字符转换
 *
 *  @param ArabicNumber 罗马字符
 *
 *  @return 阿拉伯字符
 */
-(NSInteger)getArabicSymbolWithRomanSymbol:(NSString*)romanSymbol;


@end
