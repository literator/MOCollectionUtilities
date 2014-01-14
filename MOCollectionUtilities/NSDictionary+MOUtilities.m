//
//  Created by Maciej Oczko on 13/01/14.
//  Copyright (c) 2014 Maciej Oczko. All rights reserved.
//

#import "NSDictionary+MOUtilities.h"

@implementation NSDictionary (MOUtilities)

- (BOOL)isEmpty {
    return [self count] == 0;
}

- (NSDictionary *)map:(id (^)(id key, id object))block {
    NSAssert(block != nil, @"Map block shouldn't be nil.");
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    for (id key in self) {
        id mappedObject = block(key, self[key]);
        dictionary[key] = mappedObject;
    }
    return dictionary;
}

- (NSDictionary *)filter:(BOOL (^)(id key, id object))block {
    NSAssert(block != nil, @"Filter block shouldn't be nil.");
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    for (id key in self) {
        BOOL shouldAddObjectToDictionary = block(key, self[key]);
        if (shouldAddObjectToDictionary) {
            dictionary[key] = self[key];
        }
    }
    return dictionary;
}

- (NSDictionary *)without:(NSArray *)keys {
    NSMutableDictionary *mutableDictionary = [NSMutableDictionary dictionaryWithDictionary:self];
    [mutableDictionary removeObjectsForKeys:keys];
    return mutableDictionary;
}

- (NSDictionary *)dictionaryWithObjectsAndKeysFromDictionary:(NSDictionary *)otherDictionary {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary:self];
    [dictionary addEntriesFromDictionary:otherDictionary];
    return dictionary;
}

@end

