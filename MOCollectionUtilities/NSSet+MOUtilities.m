//
//  Created by Maciej Oczko on 13/01/14.
//  Copyright (c) 2014 Maciej Oczko. All rights reserved.
//

#import "NSSet+MOUtilities.h"

@implementation NSSet (MOUtilities)

- (BOOL)isEmpty {
    return [self count] == 0;
}

- (instancetype)map:(id (^)(id object))block {
    NSAssert(block != nil, @"Map block shouldn't be nil.");
    NSMutableSet *set = [NSMutableSet set];
    [self performActionWithBlock:^(id object) {
        id mappedObject = block(object);
        [set addObject:mappedObject];
    }];
    return set;
}

- (instancetype)filter:(BOOL (^)(id object))block {
    NSAssert(block != nil, @"Filter block shouldn't be nil.");
    NSMutableSet *set = [NSMutableSet set];
    [self performActionWithBlock:^(id object) {
        BOOL shouldAddObjectToArray = block(object);
        if (shouldAddObjectToArray) {
            [set addObject:object];
        }
    }];
    return set;
}

- (instancetype)without:(NSArray *)elements {
    NSMutableSet *mutableSet = [NSMutableSet setWithSet:self];
    for (id element in elements) {
        [mutableSet removeObject:element];
    }
    return mutableSet;
}

#pragma mark - Helpers

- (void)performActionWithBlock:(void (^)(id object))action {
    NSAssert(action != nil, @"Action shouldn't be nil.");
    for (NSObject <NSObject> *object in self) {
        action(object);
    }
}

@end
