//
//  Created by Maciej Oczko on 13/01/14.
//  Copyright (c) 2014 Maciej Oczko. All rights reserved.
//

#define _MO_CANT_TOUCH_THIS() // I mean, really don't touch it.

#define _MOArraysEnumeratorHelper(first, ...) \
    ({ \
        NSArray *arrays = [NSArray arrayWithObjects:__VA_ARGS__, nil]; \
        [[_MOConcatHelper(MOArray, first) alloc] initWithArrays:arrays]; \
    }) \

#define _MO_ConstructArrayBlockIdx(idx, array) array[idx]
#define _MO_ConstructArrayBlock1(array) _MO_ConstructArrayBlockIdx(0,array)
#define _MO_ConstructArrayBlock2(array) _MO_ConstructArrayBlock1(array), _MO_ConstructArrayBlockIdx(1,array)
#define _MO_ConstructArrayBlock3(array) _MO_ConstructArrayBlock2(array), _MO_ConstructArrayBlockIdx(2,array)
#define _MO_ConstructArrayBlock4(array) _MO_ConstructArrayBlock3(array), _MO_ConstructArrayBlockIdx(3,array)
#define _MO_ConstructArrayBlock5(array) _MO_ConstructArrayBlock4(array), _MO_ConstructArrayBlockIdx(4,array)
#define _MO_ConstructArrayBlock(counter,array) _MO_ConstructArrayBlock##counter(array)

#define _MO_ConstructArrayParameterBlockIdx(idx) id obj##idx
#define _MO_ConstructArrayParameterBlock1 _MO_ConstructArrayParameterBlockIdx(1)
#define _MO_ConstructArrayParameterBlock2 _MO_ConstructArrayParameterBlock1, _MO_ConstructArrayParameterBlockIdx(2)
#define _MO_ConstructArrayParameterBlock3 _MO_ConstructArrayParameterBlock2, _MO_ConstructArrayParameterBlockIdx(3)
#define _MO_ConstructArrayParameterBlock4 _MO_ConstructArrayParameterBlock3, _MO_ConstructArrayParameterBlockIdx(4)
#define _MO_ConstructArrayParameterBlock5 _MO_ConstructArrayParameterBlock4, _MO_ConstructArrayParameterBlockIdx(5)
#define _MO_ConstructArrayParameterBlock(counter) _MO_ConstructArrayParameterBlock##counter

#define _MOArrayImplementation(counter) \
    @implementation MOArray##counter { \
        NSArray *_arrays; \
    } \
        - (id)initWithArrays:(NSArray *)arrays { \
            self = [super init]; \
            if (self) { \
                 NSAssert(arrays != nil, @"Array cannot be nil."); \
                _arrays = arrays; \
            } \
            return self; \
        } \
        - (void)enumerateArraysUsingBlock:(void (^)(_MO_ConstructArrayParameterBlock(counter), NSUInteger idx, BOOL *stop))block { \
            BOOL stop = NO; \
            for (NSUInteger j = 0; j < [[_arrays firstObject] count]; j++) { \
                NSArray *objects = [_arrays _objectsAtIndex:j]; \
                block(_MO_ConstructArrayBlock(counter, objects), j, &stop); \
                if (stop) { \
                    break; \
                } \
            } \
        } \
    @end \

#define _MOArrayInterface(counter) \
    @interface MOArray##counter : NSObject \
        - (id)initWithArrays:(NSArray *)arrays; \
        - (void)enumerateArraysUsingBlock:(void (^)(_MO_ConstructArrayParameterBlock(counter), NSUInteger idx, BOOL *stop))block; \
    @end

#pragma mark - Helpers

#define _MO_NARG(...) _MO_NARG_(__VA_ARGS__, _MO_RSEQ_N())
#define _MO_NARG_(...) _MO_ARG_N(__VA_ARGS__)
#define _MO_ARG_N(_1, _2, _3, _4, _5, N, ...) N
#define _MO_RSEQ_N() 5, 4, 3, 2, 1, 0

#define _MOConcatHelper(a, b) a ## b
