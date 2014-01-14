#import "NSArray+MOUtilities.h"

@implementation NSArray (MOUtilities)

#pragma mark - Simple methods

- (BOOL)isEmpty {
    return [self count] == 0;
}

- (instancetype)arrayOfObjectsForKey:(NSString *)key {
    return [self map:^id(id object) {
        return [object valueForKey:key];
    }];
}

- (instancetype)map:(id (^)(id object))block {
    NSAssert(block != nil, @"Map block shouldn't be nil.");
    NSMutableArray *array = [NSMutableArray array];
    [self performActionWithBlock:^(id object) {
        id mappedObject = block(object);
        [array addObject:mappedObject];
    }];
    return array;
}

- (instancetype)filter:(BOOL (^)(id object))block {
    NSAssert(block != nil, @"Filter block shouldn't be nil.");
    NSMutableArray *array = [NSMutableArray array];
    [self performActionWithBlock:^(id object) {
        BOOL shouldAddObjectToArray = block(object);
        if (shouldAddObjectToArray) {
            [array addObject:object];
        }
    }];
    return array;
}

- (instancetype)reverse {
    NSMutableArray *array = [NSMutableArray array];
    [self enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [array addObject:obj];
    }];
    return array;
}

- (instancetype)without:(NSArray *)elements {
    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:self];
    for (id element in elements) {
        [mutableArray removeObject:element];
    }
    return mutableArray;
}

- (NSDictionary *)dictionaryWithValuesForKeysAsProperty:(NSString *)propertyName {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    for (id object in self) {
        id value = [object valueForKey:propertyName];
        if (!value) @throw [NSException exceptionWithName:@"MOCollectionUtilitiesException" reason:@"The property can't be nil!" userInfo:nil];
        dictionary[value] = object;
    }
    return dictionary;
}

- (NSDictionary *)dictionaryWithValuesForCustomKeys:(id (^)(id object))block {
    NSAssert(block != nil, @"Block cannot be nil.");
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    for (id object in self) {
        id value = block(object);
        if (!value) @throw [NSException exceptionWithName:@"MOCollectionUtilitiesException" reason:@"The property can't be nil!" userInfo:nil];
        dictionary[value] = object;
    }
    return dictionary;
}

#pragma mark - Helpers

- (void)performActionWithBlock:(void (^)(id object))action {
    NSAssert(action != nil, @"Action shouldn't be nil.");
    for (NSObject <NSObject> *object in self) {
        action(object);
    }
}

- (NSArray *)_objectsAtIndex:(NSUInteger)index {
    NSMutableArray *objects = [NSMutableArray array];
    for (NSArray *array in self) {
        id object = array[index];
        [objects addObject:object];
    }
    return objects;
}

@end

_MOArrayImplementation(1)
_MOArrayImplementation(2)
_MOArrayImplementation(3)
_MOArrayImplementation(4)
_MOArrayImplementation(5)


