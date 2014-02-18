//
//  Created by Maciej Oczko on 13/01/14.
//  Copyright (c) 2014 Maciej Oczko. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface NSHashTable (MOUtilities)
- (BOOL)isEmpty;
- (instancetype)map:(id (^)(id object))block;
- (instancetype)filter:(BOOL (^)(id object))block;
- (instancetype)without:(NSArray *)elements;
@end
