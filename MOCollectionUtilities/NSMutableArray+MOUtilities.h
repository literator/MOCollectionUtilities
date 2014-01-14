//
//  Created by Maciej Oczko on 13/01/14.
//  Copyright (c) 2014 Maciej Oczko. All rights reserved.
//
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MOStackType) {
    MOStackTypeFIFO,
    MOStackTypeLIFO,
};

@interface NSMutableArray (MOUtilities)
@property(nonatomic, readonly) MOStackType stackType;

+ (instancetype)stack;
+ (instancetype)stackWithType:(MOStackType)type;

- (void)push:(id)object;
- (id)pop;
- (id)peek;
@end
