## Description

MOCollectionUtilities is a set of useful method gathered in categories for common Foundation collection classes.

## Features

* __Breakthrough__ *isEmpty* method
* Multi-array objects enumeration
* Array and Dictionary operations
 * Mapping
 * Filtering
 * Removing entries
 * Reversing (array only)
 * Creating array for objects with key paths
* Stack simulation for mutable array

All operations return new immutable object.

## Basic usage

### isEmpty

Instead of :

```objective-c
if ([array count] == 0) {
    // something
}
```

You can use completely _breakthrough_ method and write:

```objective-c
if([array isEmpty) {
   // something
}
```

It works with most common collection classes.

### Multi array enumeration

If you have many arrays with equal count of objects, you can enumerate them all at once, e.g.:

```objective-c
[MOArraysEnumerator(array1, array2, array3) enumerateArraysUsingBlock:^(id obj1, id obj2, id obj3, NSUInteger idx, BOOL *stop) {
    // obj1 is array1[idx], obj2 is array2[idx], obj3 is array3[idx]
}];
```

You can put into `MOArraysEnumerator` macro up to 5 arrays and autocompletion will help you to implement proper method (easy use with Appcode).

### Mapping

#### Array 

Let's assume you have an array like:

```objective-c
NSArray *array = @[
    @{
        @"number" : @1,
    },
    // and so on
];
```

You can map such array into a new one having only doubled numbers:

```objective-c
NSArray *numbers = [array filter:^BOOL(NSDictionary *dictionary) {
    return @( [dictionary[@"number"] integerValue] * 2 );
}];
```

#### Dictionary

Let's assume you have a dictionary like:

```objective-c
NSDicationary *dictionary = @{
    @"number0" : @1,
    @"number1" : @2,
    // and so on
};
```
You can map such dictionary into a new one:

```objective-c
NSDictionary *differentDictionary = [dictionary map:^id(NSString *key, NSNumber *number) {
    NSUInteger keyLength = [key length];
    if (keyLength == 2) {
        return @( [number integerValue] * 2 );
    } else {
        return obj;
    }
}];
```

### Filtering

#### Array

You can filter array:

```objective-c
NSArray *differentArray = [array filter:^BOOL(NSDictionary *dictionary) {
    return [dictionary[@"number"] integerValue] % 2 == 0;
}];
```

#### Dictionary

You can filter dictionary:

```objective-c
NSDictionary *filteredDictionary = [dictionary filter:^BOOL(NSString *key, NSNumber *number) {
    return [key length] % 2 == 0;
}];
```

### Removing entries

#### Array

You can remove a couple of object from array easy:

```objective-c
NSArray *arrayFixtures = [array without:@[
    obj1, obj2, obj3
]];
```

#### Dictionary

You can remove a few keys (with related objects) from dictionary:

```objective-c
NSDictionary *selectedDictionary = [dictionary without:@[
     @"1", @"2", @"3"
]];
```

### Other operations

#### Reversing

Return new array instance with objects in reversed order:

```objective-c
NSArray *reversedArray = [array reverse];
```

#### Sub objects array creation

If you'd like to make an array of objects which are held in a property of current array items, you can write:

```objective-c
NSArray *numbers = [array arrayOfObjectsForKey:NSStringFromSelector(@selector(number))];
```

#### _dictionaryWithValuesForKeysAsProperty_

Tricky one. Create a dictionary where the key is the property and the value is the object.

```objective-c
NSString *propertyString = NSStringFromSelector(@selector(number));
NSDictionary *dictionary = [array dictionaryWithValuesForKeysAsProperty:propertyString];
```

#### _dictionaryWithValuesForCustomKeys_

Very similar as previous operation, but you can provide custom key.

```objective-c
NSDictionary *dictionary = [array dictionaryWithValuesForCustomKeys:^id(NSDictionary *dictionary) {
    return [NSString stringWithFormat:@"%d", [dictionary[@"number"] integerValue] * 2];
}];
```

#### Dictionaries union

Very simple and easy method that creates new dictionary which is an union of two:

```objective-c
NSDictionary *first = @{ ... };
NSDictionary *second = @{ ... };
NSDictionary *third = [first dictionaryWithObjectsAndKeysFromDictionary:second];
```

### Chaining

It's possible to chain all mentioned methods, because each of them return new, immutable object. 
So you can write something like that:

```objective-c
NSArray *brandNewArray = [[[[_fixtures map:^id(id object) {
    // map objects
    return mapping;
}] filter:^BOOL(id object) {
    // filter objects
    return filterCondition;
}] without:@[
    // list of unwanted objects
]] reverse];
```

### Stack-like methods

You can use two types of stack: FIFO and LIFO.

On `NSMutableArray` you can use following methods:

* `stack` - simple factory method which creates FIFO stack by default
* `stackWithType:` - factory method which creates FIFO or LIFO stack
* `push:` - alias for `addObject:`
* `peek` - returns from the beginning or from the end of array, depending on stack type (FIFO, LIFO) 
* `pop` - like `peek` but additionally it removes object from stack

## Installation

MOCollectionUtilities is available through CocoaPods.

### CocoaPods

Edit your Podfile:

    edit Podfile
    pod 'MOCollectionUtilities', '1.0.0'

Now you can install MOCollectionUtilities:
    
    pod update

Or if you use Appcode simply click to install missing pods.

#### Include header

    #import <MOCollectionUtilities/MOCollectionUtilities.h>

## Changelog

#### 1.0.1

* Added map, filter and without methods to NSSet and NSHashTable.

## License

MOCollectionUtilities is available under the MIT license.
