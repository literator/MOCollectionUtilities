//
//  Created by Maciej Oczko on 13/01/14.
//  Copyright (c) 2014 Maciej Oczko. All rights reserved.
//
#import "NSHashTable+MOUtilities.h"


@implementation NSHashTable (MOUtilities)

- (BOOL)isEmpty {
    return [self count] == 0;
}

- (instancetype)map:(id (^)(id object))block {
    NSAssert(block != nil, @"Map block shouldn't be nil.");
    NSHashTable *hashTable = [[NSHashTable alloc] initWithPointerFunctions:self.pointerFunctions capacity:[self count]];
    [self performActionWithBlock:^(id object) {
        id mappedObject = block(object);
        [hashTable addObject:mappedObject];
    }];
    return hashTable;
}

- (instancetype)filter:(BOOL (^)(id object))block {
    NSAssert(block != nil, @"Filter block shouldn't be nil.");
    NSHashTable *hashTable = [[NSHashTable alloc] initWithPointerFunctions:self.pointerFunctions capacity:[self count]];
    [self performActionWithBlock:^(id object) {
        BOOL shouldAddObjectToArray = block(object);
        if (shouldAddObjectToArray) {
            [hashTable addObject:object];
        }
    }];
    return hashTable;
}

- (instancetype)without:(NSArray *)elements {
    NSHashTable *hashTable = [[NSHashTable alloc] initWithPointerFunctions:self.pointerFunctions capacity:[self count]];
    [hashTable unionHashTable:self];
    for (id element in elements) {
        [hashTable removeObject:element];
    }
    return hashTable;
}

#pragma mark - Helpers

- (void)performActionWithBlock:(void (^)(id object))action {
    NSAssert(action != nil, @"Action shouldn't be nil.");
    for (NSObject <NSObject> *object in self) {
        action(object);
    }
}

@end
