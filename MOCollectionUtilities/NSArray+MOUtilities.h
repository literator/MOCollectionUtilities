//
//  Created by Maciej Oczko on 13/01/14.
//  Copyright (c) 2014 Maciej Oczko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MOCollectionUtilitiesMacros.h"

#define MOArraysEnumerator(first, ...) _MOArraysEnumeratorHelper(_MO_NARG(first, __VA_ARGS__), first, __VA_ARGS__)

@interface NSArray (MOUtilities)
- (BOOL)isEmpty;
- (instancetype)reverse;

- (instancetype)arrayOfObjectsForKey:(NSString *)key;
- (instancetype)map:(id (^)(id object))block;
- (instancetype)filter:(BOOL (^)(id object))block;
- (instancetype)without:(NSArray *)elements;

- (NSDictionary *)dictionaryWithValuesForKeysAsProperty:(NSString *)propertyName;
- (NSDictionary *)dictionaryWithValuesForCustomKeys:(id (^)(id object))block;
@end

_MO_CANT_TOUCH_THIS()

_MOArrayInterface(1)
_MOArrayInterface(2)
_MOArrayInterface(3)
_MOArrayInterface(4)
_MOArrayInterface(5)
