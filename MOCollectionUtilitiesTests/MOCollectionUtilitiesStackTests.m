//
//  Created by Maciej Oczko on 13/01/14.
//  Copyright (c) 2014 Maciej Oczko. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MOCollectionUtilities.h"

@interface MOCollectionUtilitiesStackTests : XCTestCase

@end

@implementation MOCollectionUtilitiesStackTests {
    NSMutableArray *_fifoStack;
    NSMutableArray *_lifoStack;
}

- (void)setUp {
    _fifoStack = [NSMutableArray stackWithType:MOStackTypeFIFO];
    [_fifoStack push:@1];
    [_fifoStack push:@2];
    [_fifoStack push:@3];
    [_fifoStack push:@4];

    _lifoStack = [NSMutableArray stackWithType:MOStackTypeLIFO];
    [_lifoStack push:@1];
    [_lifoStack push:@2];
    [_lifoStack push:@3];
    [_lifoStack push:@4];

    [super setUp];
}

- (void)tearDown {
    _fifoStack = nil;
    _lifoStack = nil;
    [super tearDown];
}

- (void)testStackTypes {
    XCTAssert(_fifoStack.stackType == MOStackTypeFIFO, @"Wrong stack type");
    XCTAssert(_lifoStack.stackType == MOStackTypeLIFO, @"Wrong stack type");
}

- (void)testCounts {
    XCTAssert([_fifoStack count] == 4, @"Wrong number of elements in fifo stack.");
    XCTAssert([_lifoStack count] == 4, @"Wrong number of elements in lifo stack.");
}

#pragma mark - FIFO stack tests

- (void)testFIFOPoppingObject {
    id object = [_fifoStack pop];
    XCTAssert([object isKindOfClass:[NSNumber class]], @"Wrong object class.");
    XCTAssert([object isEqualToNumber:@1], @"Wrong object value.");
    XCTAssert([_fifoStack count] == 3, @"Wrong number of elements in stack.");
}

- (void)testFIFOPeekingObject {
    id object = [_fifoStack peek];
    XCTAssert([object isKindOfClass:[NSNumber class]], @"Wrong object class.");
    XCTAssert([object isEqualToNumber:@1], @"Wrong object value.");
    XCTAssert([_fifoStack count] == 4, @"Wrong number of elements in stack.");
}

#pragma mark - LIFO stack tests

- (void)testLIFOPoppingObject {
    id object = [_lifoStack pop];
    XCTAssert([object isKindOfClass:[NSNumber class]], @"Wrong object class.");
    XCTAssert([object isEqualToNumber:@4], @"Wrong object value.");
    XCTAssert([_lifoStack count] == 3, @"Wrong number of elements in stack.");
}

- (void)testLIFOPeekingObject {
    id object = [_lifoStack peek];
    XCTAssert([object isKindOfClass:[NSNumber class]], @"Wrong object class.");
    XCTAssert([object isEqualToNumber:@4], @"Wrong object value.");
    XCTAssert([_lifoStack count] == 4, @"Wrong number of elements in stack.");
}

@end
