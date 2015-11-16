//
//  IntergalacticConversionRule+RuleTool.m
//  Merchant's GuideDemo
//
//  Created by jsonmess on 15/11/15.
//  Copyright © 2015年 jsonmess. All rights reserved.
//

#import "IntergalacticConversionRuleTool.h"

@implementation IntergalacticConvaersionRuleTool

/**
 *  将数拆分
 */
+(NSArray *)getFormNumberArray:(NSInteger)number
{
    NSMutableArray *array = [NSMutableArray array];
    do
    {
        NSInteger tmpNum = number%10;
        number = number / 10;
        [array addObject:[NSNumber numberWithInteger:tmpNum]];
        
    }while (number > 0);
    NSArray*  tmpArray = [[array reverseObjectEnumerator] allObjects];
    return tmpArray;
}

+ (BOOL)checkIsTheAvailableNumberStr:(NSString *)str
{
    NSString* number=@"^[0-9]+$";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
    return [numberPre evaluateWithObject:str];
}

@end
