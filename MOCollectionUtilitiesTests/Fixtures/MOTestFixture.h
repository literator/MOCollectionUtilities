#import <Foundation/Foundation.h>


@interface MOTestFixture : NSObject
@property(nonatomic, readonly) NSNumber *number;
@property(nonatomic, readonly) CGFloat cgFloat;

- (instancetype)initWithNumber:(NSNumber *)number cgFloat:(CGFloat)cgFloat;
- (instancetype)initWithNumber:(NSNumber *)number;
- (instancetype)initWithCgFloat:(CGFloat)cgFloat;

+ (instancetype)fixtureWithCgFloat:(CGFloat)cgFloat;
+ (instancetype)fixtureWithNumber:(NSNumber *)number;
+ (instancetype)fixtureWithNumber:(NSNumber *)number cgFloat:(CGFloat)cgFloat;

@end
