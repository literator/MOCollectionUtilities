//
//  Created by Maciej Oczko on 21/01/14.
//  Copyright (c) 2014 Maciej Oczko. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MOTestFixture.h"
#import "MOCollectionUtilities.h"

@interface MOCollectionUtilitiesDictionaryTests : XCTestCase

@end

@implementation MOCollectionUtilitiesDictionaryTests {
    NSDictionary *_fixtures;
}

- (void)setUp {
    NSMutableDictionary *fixtures = [NSMutableDictionary dictionary];
    for (NSUInteger j = 0; j < 1000; j++) {
        fixtures[[@(j) stringValue]] = [MOTestFixture fixtureWithNumber:@(j) cgFloat:(CGFloat) j];
    }
    _fixtures = fixtures;
    [super setUp];
}

- (void)tearDown {
    _fixtures = nil;
    [super tearDown];
}

#pragma mark - Tests

- (void)testMapWithBlock {
    NSDictionary *mappedFixtures = [_fixtures map:^id(NSString *key, MOTestFixture *fixture) {
        NSUInteger keyLength = [key length];
        if (keyLength == 2) {
            return [MOTestFixture fixtureWithNumber:@(fixture.number.integerValue * 2) cgFloat:fixture.cgFloat * 2];
        } else {
            return fixture;
        }
    }];

    XCTAssert([mappedFixtures[@"1"] isEqual:_fixtures[@"1"]], @"Objects should be equal.");
    XCTAssert([mappedFixtures[@"100"] isEqual:_fixtures[@"100"]], @"Objects should be equal.");

    MOTestFixture *fixture = mappedFixtures[@"40"];
    MOTestFixture *originalFixture = _fixtures[@"40"];

    XCTAssert(fixture.number.integerValue == originalFixture.number.integerValue * 2, @"Object should have proper interer value.");
}

- (void)testFilterWithBlock {
    NSDictionary *filteredDictionary = [_fixtures filter:^BOOL(NSString *key, MOTestFixture *fixture) {
        return [key integerValue] % 2 == 0;
    }];

    XCTAssert([filteredDictionary count] == [_fixtures count] * 0.5, @"Wrong dictionary count.");
    XCTAssert(filteredDictionary[@"2"] != nil, @"Object should exist");
    XCTAssert(filteredDictionary[@"1"] == nil, @"Object shouldn't exist");
}

- (void)testWithoutMethod {
    NSDictionary *selectedDictionary = [_fixtures without:@[
            @"1", @"2", @"3"
    ]];

    XCTAssert([selectedDictionary count] == [_fixtures count] - 3, @"Wrong count of elements.");
    XCTAssert(selectedDictionary[@"1"] == nil, @"Object shoudn't exist.");
    XCTAssert(selectedDictionary[@"2"] == nil, @"Object shoudn't exist.");
    XCTAssert(selectedDictionary[@"3"] == nil, @"Object shoudn't exist.");
}

- (void)testDictionariesUnion {
    NSDictionary *first = @{
            @"1" : @1,
            @"2" : @2,
            @"3" : @3,
    };
    NSDictionary *second = @{
            @"3" : @3,
            @"4" : @4,
            @"5" : @5,
    };

    NSDictionary *third = [first dictionaryWithObjectsAndKeysFromDictionary:second];

    for (NSString *key in first) {
        XCTAssert([third[key] isEqual:first[key]]);
    }
    for (NSString *key in second) {
        XCTAssert([third[key] isEqual:second[key]]);
    }
}

@end
