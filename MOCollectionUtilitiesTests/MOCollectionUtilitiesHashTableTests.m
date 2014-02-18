//
//  Created by Maciej Oczko on 13/01/14.
//  Copyright (c) 2014 Maciej Oczko. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MOCollectionUtilities.h"
#import "MOTestFixture.h"

@interface MOCollectionUtilitiesHashTableTests : XCTestCase

@end

@implementation MOCollectionUtilitiesHashTableTests {
    NSHashTable *_fixtures;
}

- (void)setUp {
    NSHashTable *fixtures = [NSHashTable hashTableWithOptions:NSHashTableStrongMemory];
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
    NSHashTable *hashTable = [NSHashTable hashTableWithOptions:NSHashTableStrongMemory];
    XCTAssert([hashTable isEmpty], @"HashTable should be empty.");
}

- (void)testIfArrayIsNotEmpty {
    NSHashTable *hashTable = [NSHashTable hashTableWithOptions:NSHashTableStrongMemory];
    [hashTable addObject:@1];
    XCTAssert(![hashTable isEmpty], @"HashTable should not be empty.");
}

#pragma mark - Map tests

- (void)testMappingProperty {
    NSHashTable *numbers = [_fixtures map:^id(MOTestFixture *fixture) {
        return fixture.number;
    }];

    XCTAssert([numbers count] == [_fixtures count], @"HashTable has wrong number of arguments.");

    for (NSNumber *number in numbers) {
        XCTAssert([number isKindOfClass:[NSNumber class]], @"Wrong object class.");
    }
}

- (void)testMapWithMultiplyingNumbers {
    NSHashTable *numbers = [_fixtures map:^id(MOTestFixture *fixture) {
        return @([fixture.number integerValue] * 2);
    }];

    XCTAssert([numbers count] == [_fixtures count], @"HashTable has wrong number of arguments.");

    for (NSNumber *number in numbers) {
        XCTAssert([number isKindOfClass:[NSNumber class]], @"Wrong object class.");
        NSSet *singleSet = [[_fixtures setRepresentation] filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"number == %d", [number integerValue] / 2]];
        XCTAssert([singleSet count] == 1, @"Badly mapped object or no object at all.");
    }
}

#pragma mark - Filter tests

- (void)testFilterForFilteringEven {
    NSHashTable *numbers = [_fixtures filter:^BOOL(MOTestFixture *fixture) {
        return fixture.number.integerValue % 2 == 0;
    }];

    XCTAssert([numbers count] == [_fixtures count] / 2, @"HashTable has wrong number of arguments.");
}

#pragma mark - Without tests

- (void)testWithoutMethod {
    id obj1 = [_fixtures anyObject];

    NSHashTable *selectedFixtures = [_fixtures without:@[
            obj1,
    ]];

    XCTAssert([selectedFixtures count] == [_fixtures count] - 1, @"Wrong number of elements");
    XCTAssert(![selectedFixtures containsObject:obj1], @"HashTable shouldn't contain object");
}

@end
