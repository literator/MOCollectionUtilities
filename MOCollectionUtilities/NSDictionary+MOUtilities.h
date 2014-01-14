//
//  Created by Maciej Oczko on 13/01/14.
//  Copyright (c) 2014 Maciej Oczko. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "MOCollectionUtilitiesMacros.h"

@interface NSDictionary (MOUtilities)
- (BOOL)isEmpty;
- (NSDictionary *)map:(id (^)(id key, id object))block;
- (NSDictionary *)filter:(BOOL (^)(id key, id object))block;
- (NSDictionary *)without:(NSArray *)keys;
- (NSDictionary *)dictionaryWithObjectsAndKeysFromDictionary:(NSDictionary *)otherDictionary;
@end

