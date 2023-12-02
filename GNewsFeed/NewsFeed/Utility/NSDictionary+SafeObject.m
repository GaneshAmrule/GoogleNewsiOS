//
//  NSDictionary+SafeObject.m
//  GNewsFeed
//
//  Created by Ganesh Amrule on 02/12/23.
//

#import "NSDictionary+SafeObject.h"

@implementation NSDictionary (SafeObject)

-(id)safeObjectForKey:(NSString*)key {
    id value = [self objectForKey:key];
    if (value !=nil && ![value isKindOfClass:[NSNull class]]) {
        return value;
    } else {
        return @"";
    }
}

@end
