//
//  CardDeckTests.m
//  W4_KVO
//
//  Created by 김성희 on 2015. 3. 26..
//  Copyright (c) 2015년 skim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "CardDeck.h"

@interface CardDeck (Test)

- (NSString *)getStringWithShape:(int)shape number:(int)number;

@end

@interface CardDeckTests : XCTestCase

@property (nonatomic) CardDeck *card;

@end

@implementation CardDeckTests

- (void)setUp {
    [super setUp];

    _card = [[CardDeck alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testGetStringWithShape {
    NSString *result = [_card getStringWithShape:1 number:0];
    
    XCTAssertEqualObjects(result, @"hA");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
