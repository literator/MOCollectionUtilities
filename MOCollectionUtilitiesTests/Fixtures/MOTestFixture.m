#import "MOTestFixture.h"


@implementation MOTestFixture {

}

- (instancetype)initWithCgFloat:(CGFloat)cgFloat {
    self = [super init];
    if (self) {
        _cgFloat = cgFloat;
    }

    return self;
}

+ (instancetype)fixtureWithCgFloat:(CGFloat)cgFloat {
    return [[self alloc] initWithCgFloat:cgFloat];
}


- (instancetype)initWithNumber:(NSNumber *)number {
    self = [super init];
    if (self) {
        _number = number;
    }

    return self;
}

+ (instancetype)fixtureWithNumber:(NSNumber *)number {
    return [[self alloc] initWithNumber:number];
}


- (instancetype)initWithNumber:(NSNumber *)number cgFloat:(CGFloat)cgFloat {
    self = [super init];
    if (self) {
        _number = number;
        _cgFloat = cgFloat;
    }

    return self;
}

+ (instancetype)fixtureWithNumber:(NSNumber *)number cgFloat:(CGFloat)cgFloat {
    return [[self alloc] initWithNumber:number cgFloat:cgFloat];
}

@end
