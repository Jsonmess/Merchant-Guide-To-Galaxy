//
//  IntergalacticSymbol.m
//  Merchant's GuideDemo
//
//  Created by jsonmess on 15/11/14.
//  Copyright © 2015年 jsonmess. All rights reserved.
//

#import "IntergalacticSymbol.h"

@interface IntergalacticSymbol()

@property (nonatomic,strong)NSDictionary *IntergalacticSymbolMappingDic;

@end

@implementation IntergalacticSymbol

-(instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [self initIntergalacticSymbolMappingDic];
    }
    
    return self;
}
/**
 *  初始化--星际字符转换表
 */
-(void)initIntergalacticSymbolMappingDic
{
    self.IntergalacticSymbolMappingDic = @{
                                           @"I":@1,@"V":@5,
                                           @"X":@10,@"L":@50,
                                           @"C":@100,@"D":@500,
                                           @"M":@1000
                                          };
}

/**
 *  罗马字符-->阿拉伯字符
 */
-(NSInteger)getArabicSymbolWithRomanSymbol:(NSString *)romanSymbol
{
    NSNumber * tmpSymbolObj = [self.IntergalacticSymbolMappingDic valueForKey:romanSymbol];
    return tmpSymbolObj.integerValue;
}

/**
 *  阿拉伯字符-->罗马字符
 */
-(NSString *)getRomanSymbolWithArabicSymbol:(NSInteger)ArabicSymbol
{
    NSNumber *tmpSymbolObj = [NSNumber numberWithInteger:ArabicSymbol];
    NSArray *objectAllMapKeys = [self.IntergalacticSymbolMappingDic allKeysForObject:tmpSymbolObj];
    NSString *tmpKey = [objectAllMapKeys firstObject];
    return tmpKey;
}

@end
