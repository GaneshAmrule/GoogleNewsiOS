//
//  NSDictionary+NSDictionary_SafeObject.h
//  GNewsFeed
//
//  Created by Ganesh Amrule on 02/12/23.
//

#import <Foundation/Foundation.h>


@interface NSDictionary (SafeObject)

-(id)safeObjectForKey:(NSString*)key;

@end

