//
//  Created by Maciej Oczko on 13/01/14.
//  Copyright (c) 2014 Maciej Oczko. All rights reserved.
//
#import "NSMutableArray+MOUtilities.h"
#import "NSArray+MOUtilities.h"
#import <objc/runtime.h>

static char kMOStackTypeAssociatedKey;

@implementation NSMutableArray (MOUtilities)

@dynamic stackType;

#pragma mark - Queue

+ (instancetype)stack {
    return [self stackWithType:MOStackTypeFIFO];
}

+ (instancetype)stackWithType:(MOStackType)type {
    NSMutableArray *array = [[self alloc] init];
    objc_setAssociatedObject(array, &kMOStackTypeAssociatedKey, @(type), OBJC_ASSOCIATION_COPY_NONATOMIC);
    return array;
}

- (MOStackType)stackType {
    NSNumber *type = objc_getAssociatedObject(self, &kMOStackTypeAssociatedKey);
    return (MOStackType) [type integerValue];
}

- (void)push:(id)object {
    [self addObject:object];
}

- (id)pop {
    id object = [self peek];
    !object ?: [self removeObject:object];
    return object;
}

- (id)peek {
    NSUInteger index = [self indexOfLastObjectConsideringStackType];
    return [self isEmpty] ? nil : self[index];
}

- (NSUInteger)indexOfLastObjectConsideringStackType {
    NSUInteger index = 0;
    switch ([self stackType]) {
        case MOStackTypeFIFO:
            index = 0;
            break;
        case MOStackTypeLIFO:
            index = [self count] - 1;
            break;
    }
    return index;
}

@end
