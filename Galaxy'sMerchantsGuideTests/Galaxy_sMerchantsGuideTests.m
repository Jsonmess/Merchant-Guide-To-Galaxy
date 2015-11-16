//
//  Galaxy_sMerchantsGuideTests.m
//  Galaxy'sMerchantsGuideTests
//
//  Created by jsonmess on 15/11/11.
//  Copyright © 2015年 jsonmess. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "IntergalacticSymbol.h"
#import "IntergalacticConversionRule.h"
@interface Galaxy_sMerchantsGuideTests : XCTestCase

@end

@implementation Galaxy_sMerchantsGuideTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testMapping
{
    IntergalacticSymbol * testSymbol = [[IntergalacticSymbol alloc] init];
    NSInteger x = [testSymbol getArabicSymbolWithRomanSymbol:@"X"];
    NSInteger i = [testSymbol getArabicSymbolWithRomanSymbol:@"I"];
    NSInteger l = [testSymbol getArabicSymbolWithRomanSymbol:@"L"];
    NSInteger d = [testSymbol getArabicSymbolWithRomanSymbol:@"D"];
    NSInteger c = [testSymbol getArabicSymbolWithRomanSymbol:@"C"];
    NSInteger m = [testSymbol getArabicSymbolWithRomanSymbol:@"M"];
    NSInteger v = [testSymbol getArabicSymbolWithRomanSymbol:@"V"];
    NSAssert(x==10, @"x faild");
    NSAssert(i==1, @"i faild");
    NSAssert(l==50, @"l faild");
    NSAssert(d==500, @"d faild");
    NSAssert(c==100, @"c faild");
    NSAssert(v==5, @"v faild");
    NSAssert(m==1000, @"m faild");
}


- (void)testArabicToRomanNumber
{
    IntergalacticConversionRule *rule = [[IntergalacticConversionRule alloc] init];
    NSString *romanNumber = [rule getRomanNumberWithArabicNumber:1903];
    NSAssert([romanNumber isEqualToString:@"MCMIII"], @"arabicToRomanNumber faild");
}

- (void)testRomanNumberToArabic
{
    IntergalacticConversionRule *rule = [[IntergalacticConversionRule alloc] init];
    NSInteger arabicNumber = [rule getArabicNumberWithRomanNumber:@"MCMXLIV"];
    NSAssert(arabicNumber == 1944, @"arabicToRomanNumber faild");
}
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}
@end
