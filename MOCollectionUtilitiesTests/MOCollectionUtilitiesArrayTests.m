//
//  Created by Maciej Oczko on 13/01/14.
//  Copyright (c) 2014 Maciej Oczko. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MOCollectionUtilities.h"
#import "MOTestFixture.h"

@interface MOCollectionUtilitiesArrayTests : XCTestCase

@end

@implementation MOCollectionUtilitiesArrayTests {
    NSArray *_fixtures;
}

- (void)setUp {
    NSMutableArray *fixtures = [NSMutableArray array];
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
    NSArray *array = [NSArray array];
    XCTAssert([array isEmpty], @"Array should be empty.");
}

- (void)testIfArrayIsNotEmpty {
    NSArray *array = @[@1];
    XCTAssert(![array isEmpty], @"Array should not be empty.");
}

#pragma mark - Array of objects tests

- (void)testArrayOfObjectsWithNumberProperty {
    NSArray *numbers = [_fixtures arrayOfObjectsForKey:NSStringFromSelector(@selector(number))];

    XCTAssert([numbers count] == [_fixtures count], @"Array has wrong number of arguments.");

    [numbers enumerateObjectsUsingBlock:^(NSNumber *number, NSUInteger idx, BOOL *stop) {
        XCTAssert([number isKindOfClass:[NSNumber class]], @"Wrong object class.");
        XCTAssert([number isEqualToNumber:@(idx)], @"Wrong number.");
    }];
}

- (void)testArrayOfObjectsWithPrimitiveFloatProperty {
    NSArray *numbers = [_fixtures arrayOfObjectsForKey:NSStringFromSelector(@selector(cgFloat))];

    XCTAssert([numbers count] == [_fixtures count], @"Array has wrong number of arguments.");

    [numbers enumerateObjectsUsingBlock:^(NSNumber *number, NSUInteger idx, BOOL *stop) {
        XCTAssert([number isKindOfClass:[NSNumber class]], @"Wrong object class.");
        XCTAssert([number isEqualToNumber:@((CGFloat) idx)], @"Wrong number.");
    }];
}

#pragma mark - Map tests

- (void)testMappingProperty {
    NSArray *numbers = [_fixtures map:^id(MOTestFixture *fixture) {
        return fixture.number;
    }];

    XCTAssert([numbers count] == [_fixtures count], @"Array has wrong number of arguments.");

    [numbers enumerateObjectsUsingBlock:^(NSNumber *number, NSUInteger idx, BOOL *stop) {
        XCTAssert([number isKindOfClass:[NSNumber class]], @"Wrong object class.");
        XCTAssert([number isEqualToNumber:@(idx)], @"Wrong number.");
    }];
}

- (void)testMapWithMultiplyingNumbers {
    NSArray *numbers = [_fixtures map:^id(MOTestFixture *fixture) {
        return @([fixture.number integerValue] * 2);
    }];

    XCTAssert([numbers count] == [_fixtures count], @"Array has wrong number of arguments.");

    [numbers enumerateObjectsUsingBlock:^(NSNumber *number, NSUInteger idx, BOOL *stop) {
        XCTAssert([number isKindOfClass:[NSNumber class]], @"Wrong object class.");
        XCTAssert([number isEqualToNumber:@(idx * 2)], @"Wrong number.");
    }];
}

#pragma mark - Filter tests

- (void)testFilterForFilteringEven {
    NSArray *numbers = [_fixtures filter:^BOOL(MOTestFixture *fixture) {
        return fixture.number.integerValue % 2 == 0;
    }];

    XCTAssert([numbers count] == [_fixtures count] / 2, @"Array has wrong number of arguments.");

    for (NSUInteger j = 0, k = 0; j < [numbers count]; j++, k += 2) {
        NSInteger value = [[numbers[j] number] integerValue];
        XCTAssert(value == k, @"Wrong filtered value");
    }
}

#pragma mark - Without tests

- (void)testWithoutMethod {
    id obj1 = _fixtures[1];
    id obj2 = _fixtures[4];
    id obj3 = _fixtures[5];

    NSArray *selectedFixtures = [_fixtures without:@[
            obj1, obj2, obj3
    ]];

    XCTAssert([selectedFixtures count] == [_fixtures count] - 3, @"Wrong number of elements");
    XCTAssert(![selectedFixtures containsObject:obj1], @"Array shouldn't contain object");
    XCTAssert(![selectedFixtures containsObject:obj2], @"Array shouldn't contain object");
    XCTAssert(![selectedFixtures containsObject:obj3], @"Array shouldn't contain object");
}

#pragma mark - Reverse tests

- (void)testReverse {
    NSArray *reversedFixtures = [_fixtures reverse];

    for (NSInteger j = [_fixtures count] - 1, i = 0; j >= 0, i < [reversedFixtures count]; j--, i++) {
        XCTAssert([_fixtures[j] isEqual:reversedFixtures[i]], @"Elements should be equal.");
    }
}

- (void)testReverseWithMultiArrayEnumeration {
    NSArray *reversedFixtures = [_fixtures reverse];
    NSUInteger reversedFixturesCount = [reversedFixtures count];

    [MOArraysEnumerator(_fixtures, reversedFixtures) enumerateArraysUsingBlock:^(id obj1, id obj2, NSUInteger idx, BOOL *stop) {
        XCTAssert(![obj1 isEqual:obj2], @"Elements shouldn't be equal.");
        id objEqual = reversedFixtures[reversedFixturesCount - idx - 1];
        XCTAssert([obj1 isEqual:objEqual], @"Elements should be equal.");
    }];
}

#pragma mark - Multi array enumeration tests

- (void)testFourMultiArraysEnumeration {
    NSArray *array1 = @[@1, @2, @3, @4];
    NSArray *array2 = @[@2, @2, @2, @2];
    NSArray *array3 = @[@8, @7, @6, @4];
    NSArray *array4 = @[@1, @3, @2, @6];

    [MOArraysEnumerator(array1, array2, array3, array4) enumerateArraysUsingBlock:^(id obj1, id obj2, id obj3, id obj4, NSUInteger idx, BOOL *stop) {
        XCTAssert([obj1 isEqual:array1[idx]], @"Array item and obj should be equal.");
        XCTAssert([obj2 isEqual:array2[idx]], @"Array item and obj should be equal.");
        XCTAssert([obj3 isEqual:array3[idx]], @"Array item and obj should be equal.");
        XCTAssert([obj4 isEqual:array4[idx]], @"Array item and obj should be equal.");
    }];
}

#pragma mark - Turn into dictionary tests

- (void)testTurningIntoDictionaryWithKeyAsProperty {
    NSString *propertyString = NSStringFromSelector(@selector(number));
    NSDictionary *dictionary = [_fixtures dictionaryWithValuesForKeysAsProperty:propertyString];
    XCTAssert([dictionary[@4] isEqual:_fixtures[4]]);
}

- (void)testTurningIntoDictionaryWithCustomKey {
    NSDictionary *dictionary = [_fixtures dictionaryWithValuesForCustomKeys:^id(MOTestFixture *fixture) {
        return [NSString stringWithFormat:@"%d", [fixture.number integerValue] * 2];
    }];
    XCTAssert([dictionary[@"2"] isEqual:_fixtures[1]]);
}

@end
