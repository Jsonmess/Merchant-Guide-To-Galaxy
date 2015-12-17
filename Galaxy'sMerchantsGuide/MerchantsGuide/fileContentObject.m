//
//  fileContentObject.m
//  Merchant's GuideDemo
//
//  Created by jsonmess on 15/11/16.
//  Copyright © 2015年 jsonmess. All rights reserved.
//

#import "fileContentObject.h"
#import "IntergalacticConversionRuleTool.h"
#import "IntergalacticConversionRule.h"
#import "IntergalacticSymbol.h"

@interface fileContentObject()

@property (nonatomic,strong)IntergalacticSymbol *intergalacticSymbolObj;
@property (nonatomic,strong)IntergalacticConversionRule *intergalacticConversionRule;
@end
@implementation fileContentObject

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        self.userMappingDic = [NSMutableDictionary dictionary];
        self.intergalacticSymbolObj = [[IntergalacticSymbol alloc] init];
         self.intergalacticConversionRule = [[IntergalacticConversionRule alloc] init];
        self.resultStr = @"";
    }
    return self;
}
/**
 *  解析长句子
 *
 *  @param sentence 句子
 */
-(void)AnalysisTheDescribeSentence:(NSString*)sentence
{
   if ([sentence rangeOfString:@"?"].length <= 0)
   {
       if ([sentence rangeOfString:@"Credits"].length <= 0)
       {
           //单个定义语句
           NSArray *array = [sentence componentsSeparatedByString:@" "];
//           NSMutableArray *tmpArray = [NSMutableArray arrayWithArray:array];
//           [tmpArray removeObject:@"is"];
           [self.userMappingDic setValue:[array lastObject] forKey:[array firstObject]];
       }
       else
       {
           //含有未知定义语句
           NSArray *senseStrs = [sentence componentsSeparatedByString:@" is "];
           if(senseStrs.count <= 1)
           {
               return;
           }
           NSString * leftStr = [senseStrs firstObject];
           NSString * rightStr = [senseStrs lastObject];
           //分别对is前后句子进行解析
           //1.前面部分
           NSArray *array = [leftStr componentsSeparatedByString:@" "];
           array =  [self removeSpaceSymbol:array];
           NSString *convertStr = @"";
           NSString *unknownStr = @"";
           NSInteger theValue = 0;
           for (NSString *tmpStr in array)
           {
              if ([self.userMappingDic objectForKey:tmpStr] != nil)
              {
                  NSString * mapValue = [self.userMappingDic objectForKey:tmpStr];
                 convertStr = [NSString stringWithFormat:@"%@%@",convertStr,mapValue];
              }
              else
              {
                  //未知字符
                  unknownStr = tmpStr;
              }
           }
           //2.解析后半段
           NSArray *rightArray = [rightStr componentsSeparatedByString:@" "];
           rightArray =  [self removeSpaceSymbol:rightArray];
           for (NSString *tmpStr in rightArray)
           {
              if ([IntergalacticConvaersionRuleTool checkIsTheAvailableNumberStr:tmpStr])
              {
                  theValue = [tmpStr integerValue];
                  break;
              }
           }
           //3.计算
           double tmpNumber = [self.intergalacticConversionRule getArabicNumberWithRomanNumber:convertStr];
           double tmpResut = 0;
           if (tmpNumber > 0)
           {
               tmpResut = (double)theValue/tmpNumber;
           }
        
           [self.userMappingDic setObject:[NSString stringWithFormat:@"%lf",tmpResut] forKey:unknownStr];
//           NSString * tmpResult = [NSString stringWithFormat:@"%@"]
//           self.resultStr = [NSString stringWithFormat:@"%@%@\n",self.resultStr,]
       }
   }
   else
   {
      //含有"？"
     if ([sentence rangeOfString:@" is "].length >0)
     {
         NSArray *senseStrs = [sentence componentsSeparatedByString:@" is "];
         if(senseStrs.count <= 1)
         {
             return;
         }
         NSString * rightStr = [senseStrs lastObject];
         NSArray *rightArray = [rightStr componentsSeparatedByString:@" "];
         rightArray =  [self removeSpaceSymbol:rightArray];
         //去除问号
         rightStr = [rightStr stringByReplacingOccurrencesOfString:@"?" withString:@""];
         NSString *convertStr = @"";
         NSString *unRomanStr = @"";
         double theValue = 0;
         for (NSString *tmpStr in rightArray)
         {
            NSString *userMapStr = [self.userMappingDic objectForKey:tmpStr];
            if (userMapStr != nil)
            {
                if ([self.intergalacticSymbolObj getArabicSymbolWithRomanSymbol:userMapStr] > 0)
                {
                    convertStr = [NSString stringWithFormat:@"%@%@",convertStr,userMapStr];
                }
                else
                {
                    unRomanStr = tmpStr;
                }
            }
         }
         //计算
         NSInteger tmpNumber = [self.intergalacticConversionRule getArabicNumberWithRomanNumber:convertStr];
         double knownNumber = [[self.userMappingDic objectForKey:unRomanStr] floatValue];
         knownNumber = knownNumber == 0 ? 1:knownNumber;
         theValue = tmpNumber * knownNumber;
         NSString * tmpResult = [NSString stringWithFormat:@"%@ is %ld Credits",rightStr,(NSInteger)theValue];
         self.resultStr = [NSString stringWithFormat:@"%@%@\n",self.resultStr,tmpResult];
     }
     else
     {
         NSString *tmpResult = @"I have no idea what you are talking about";
         self.resultStr = [NSString stringWithFormat:@"%@%@\n",self.resultStr,tmpResult];
     }
   }
}

/**
 *  移除空格
 *
 *  @param array
 *
 *  @return
 */
-(NSArray*)removeSpaceSymbol:(NSArray*)array
{
    NSMutableArray * mutableArray = [NSMutableArray arrayWithArray:array];
    for (NSString *word in array) {
        if ([word isEqualToString:@""] || [word isEqualToString:@" "])
        {
            [mutableArray removeObject:word];
        }
    }
    return mutableArray;
}
@end
