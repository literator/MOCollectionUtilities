//
//  Created by Maciej Oczko on 13/01/14.
//  Copyright (c) 2014 Maciej Oczko. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MOCollectionUtilities.h"
#import "MOTestFixture.h"

@interface MOCollectionUtilitiesSetTests : XCTestCase

@end

@implementation MOCollectionUtilitiesSetTests {
    NSSet *_fixtures;
}

- (void)setUp {
    NSMutableSet *fixtures = [NSMutableSet set];
    for (NSUInteger j = 0; j < 1000; j++) {
        [fixtures addObject:[MOTestFixture fixtureWithNumber:@(j) cgFloat:(CGFloat) j]];
    }
    _fixtures = fixtures;
    [super setUp];
}

- (void)tearDown {
    _fixtures = nil;
    [super tearDown];
}

#pragma mark - IsEmpty Tests

- (void)testIfArrayIsEmpty {
    NSSet *set = [NSSet set];
    XCTAssert([set isEmpty], @"Set should be empty.");
}

- (void)testIfArrayIsNotEmpty {
    NSSet *set = [NSSet setWithObject:@1];
    XCTAssert(![set isEmpty], @"Set should not be empty.");
}

#pragma mark - Map tests

- (void)testMappingProperty {
    NSSet *numbers = [_fixtures map:^id(MOTestFixture *fixture) {
        return fixture.number;
    }];

    XCTAssert([numbers count] == [_fixtures count], @"Set has wrong number of arguments.");

    [numbers enumerateObjectsUsingBlock:^(NSNumber *number, BOOL *stop) {
        XCTAssert([number isKindOfClass:[NSNumber class]], @"Wrong object class.");
    }];
}

- (void)testMapWithMultiplyingNumbers {
    NSSet *numbers = [_fixtures map:^id(MOTestFixture *fixture) {
        return @([fixture.number integerValue] * 2);
    }];

    XCTAssert([numbers count] == [_fixtures count], @"Set has wrong number of arguments.");

    [numbers enumerateObjectsUsingBlock:^(NSNumber *number, BOOL *stop) {
        XCTAssert([number isKindOfClass:[NSNumber class]], @"Wrong object class.");
        NSSet *singleSet = [_fixtures filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"number == %d", [number integerValue] / 2]];
        XCTAssert([singleSet count] == 1, @"Badly mapped object or no object at all.");
    }];
}

#pragma mark - Filter tests

- (void)testFilterForFilteringEven {
    NSSet *numbers = [_fixtures filter:^BOOL(MOTestFixture *fixture) {
        return fixture.number.integerValue % 2 == 0;
    }];

    XCTAssert([numbers count] == [_fixtures count] / 2, @"Set has wrong number of arguments.");
}

#pragma mark - Without tests

- (void)testWithoutMethod {
    id obj1 = [_fixtures anyObject];

    NSSet *selectedFixtures = [_fixtures without:@[
            obj1,
    ]];

    XCTAssert([selectedFixtures count] == [_fixtures count] - 1, @"Wrong number of elements");
    XCTAssert(![selectedFixtures containsObject:obj1], @"Set shouldn't contain object");
}

@end
