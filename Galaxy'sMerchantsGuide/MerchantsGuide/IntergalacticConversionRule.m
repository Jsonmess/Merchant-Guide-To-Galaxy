//
//  IntergalacticConversionRule.m
//  Merchant's GuideDemo
//
//  Created by jsonmess on 15/11/14.
//  Copyright © 2015年 jsonmess. All rights reserved.
//

#import "IntergalacticConversionRule.h"
#import "IntergalacticSymbol.h"
#import "IntergalacticConversionRuleTool.h"
@implementation IntergalacticConversionRule

/**
 *  星际数字-->阿拉伯数字
 */
-(NSString *)getRomanNumberWithArabicNumber:(NSInteger)arabicNumber
{
    //1.判断是否大于等于3900---3900为阀值，为MMMCM ----（MMMC为重复字段-2900）
    NSString *romanNumberStr = @"";
    if (arabicNumber >= 3900)
    {
        NSInteger count = arabicNumber / 2900;
        arabicNumber = arabicNumber % 2900;
        for (NSInteger i = 1 ; i <= count; i++) {
            romanNumberStr = [NSString stringWithFormat:@"%@%@",romanNumberStr,@"MMMC"];
        }
    }
   //2.将数字拆分为单个字母
   NSArray *array =  [IntergalacticConvaersionRuleTool getFormNumberArray:arabicNumber];
    IntergalacticSymbol *tmpSymbol = [[IntergalacticSymbol alloc] init];
    for (NSInteger i = 0; i<array.count; i++)
    {
        //取一个数
        NSInteger tmpNumber = [array[i] integerValue];
        BOOL isTheAddition = [self checkUseTheAdditionOrSubtraction:tmpNumber];
        if (isTheAddition)
        {
          //加法
            if(tmpNumber < 4)
            {
                for (NSInteger j = 0; j < tmpNumber; j++)
                {
                    NSInteger value = powl(10, (array.count-i-1));
                    NSString * romanKey = [tmpSymbol getRomanSymbolWithArabicSymbol:value];
                     romanNumberStr = [NSString stringWithFormat:@"%@%@",romanNumberStr,romanKey];
                }
            }
            else
            {
                NSString * romanKey = [tmpSymbol getRomanSymbolWithArabicSymbol:powl(10, (array.count-i-1))*5];
                romanNumberStr = [NSString stringWithFormat:@"%@%@",romanNumberStr,romanKey];
                
                for (NSInteger j = 0; j < tmpNumber-5; j++)
                {
                    NSString * romanKey = [tmpSymbol getRomanSymbolWithArabicSymbol:powl(10, (array.count-i-1))];
                    romanNumberStr = [NSString stringWithFormat:@"%@%@",romanNumberStr,romanKey];
                }
            }
            
        }
        else
        {
            NSString * romanKey = [tmpSymbol getRomanSymbolWithArabicSymbol:powl(10, (array.count-i-1))];
            romanNumberStr = [NSString stringWithFormat:@"%@%@",romanNumberStr,romanKey];
            //减法
            if(tmpNumber == 4)
            {
                romanKey = [tmpSymbol getRomanSymbolWithArabicSymbol:powl(10, (array.count-i-1))*5];
                romanNumberStr = [NSString stringWithFormat:@"%@%@",romanNumberStr,romanKey];
            }
            else //9
            {
                romanKey = [tmpSymbol getRomanSymbolWithArabicSymbol:powl(10, (array.count-i))];
                romanNumberStr = [NSString stringWithFormat:@"%@%@",romanNumberStr,romanKey];
            }
            
        }
        
    }
    return romanNumberStr;
}

/**
 *  阿拉伯数字-->星际数字
 */
-(NSInteger)getArabicNumberWithRomanNumber:(NSString *)romanNumber
{
    //1.需要将MMCM给拆分为单个字母
    const char *chars = [romanNumber cStringUsingEncoding:NSUTF8StringEncoding];
    NSMutableArray * array  = [NSMutableArray array];
    for (int i = 0; i < strlen(chars); i++) {
        NSString * charStr = [NSString stringWithFormat:@"%c",chars[i]];
        IntergalacticSymbol *tmpSymbol = [[IntergalacticSymbol alloc] init];
        //拿到阿拉伯数字
       NSInteger tmpNumber = [tmpSymbol getArabicSymbolWithRomanSymbol:charStr];
        //第一步检查星际数字的合法性
        if (tmpNumber <= 0)
        {
            return -1;
        }
        [array addObject:[NSNumber numberWithInteger:tmpNumber]];
    }
    //2.对应映射
    NSInteger theNumber = [self caculateTheNumberWithMappingArray:[NSMutableArray arrayWithArray:array]];
   return theNumber;
}

/**
 *  根据映射后的单个数字来计算星际数字表达的数
 *
 *  @param array 映射数组
 *
 *  @return 总数
 */
-(NSInteger)caculateTheNumberWithMappingArray:(NSMutableArray*)array
{
    //总数
    NSInteger theAmount = 0;
    //1.取出index = 0和index = 1数进行比较
    do
    {
        NSInteger num0 = [[array objectAtIndex:0] integerValue];
        if(array.count == 1)
        {
          theAmount += num0;
            break;
        }
        NSInteger num1 = [[array objectAtIndex:1] integerValue];
        //第二步检查合法性
      BOOL IsLegal = [self checkTheRomanNumberIsLegal:num0 number2:num1];
        if (!IsLegal)
        {
            return -1;
        }
        if (num0 >= num1)
        {
            theAmount += num0;
            [array removeObjectAtIndex:0];
        }
//        else if (num0 == num1)
//        {
//            theAmount += (num1+num0);
//            [array removeObjectAtIndex:0];
//            [array removeObjectAtIndex:0];
//        }
        else
        {
            theAmount += (num1-num0);
           [array removeObjectAtIndex:0];
           [array removeObjectAtIndex:0];
        }
        
    }while (array.count > 0);
    
    return theAmount;
}
/**
 *  检测输入的星际数字是否合法
 *
 *  @param romanNumber 星际数字
 *
 *  @return 合法性
 */
-(BOOL)checkTheRomanNumberIsLegal:(NSInteger)value0 number2:(NSInteger)value1
{
    //1.如果数字为1，则number2只能为5 或者10--- IV 、IX
    //2.如果数字为10，则number2只能为50 或者100--- XL、XC
    //3.如果数字为100，则number2只能为500 或者1000--- CD、CM
    BOOL IsLegal = YES;
    IntergalacticSymbol *tmpSymbol = [[IntergalacticSymbol alloc] init];
    NSString *romanSymbol0 = [tmpSymbol getRomanSymbolWithArabicSymbol:value0];
    NSString *romanSymbol1 = [tmpSymbol getRomanSymbolWithArabicSymbol:value1];
    
    if( value0 >= value1)
    {
        return YES;
    }
    
    if ([romanSymbol0 isEqualToString:@"I" ] && !([romanSymbol1 isEqualToString:@"V" ]
                                                 || [romanSymbol1 isEqualToString:@"X" ]))
    {
        IsLegal = NO;
    }
    else if ([romanSymbol0 isEqualToString:@"X" ] && !([romanSymbol1 isEqualToString:@"L" ]
                                                      || [romanSymbol1 isEqualToString:@"C" ]))
    {
       IsLegal = NO;
    }
    else if ([romanSymbol0 isEqualToString:@"C" ] && !([romanSymbol1 isEqualToString:@"D" ]
                                                      || [romanSymbol1 isEqualToString:@"M" ]))
    {
       IsLegal = NO;
    }
    return IsLegal;
}


/**
 *  检查是否用加法还是减法
 *
 *  @param number 数字
 *
 *  @return YES =="加法"，NO == "减法"
 */
-(BOOL)checkUseTheAdditionOrSubtraction:(NSInteger)number
{
    if(number==4 || number == 9)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}
#pragma mark ------ 工具函数

@end
