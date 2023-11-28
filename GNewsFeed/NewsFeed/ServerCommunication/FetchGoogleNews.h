//
//  FetchGoogleNews.h
//  GNewsFeed
//
//  Created by Ganesh Amrule on 28/11/23.
//

#import <Foundation/Foundation.h>

extern NSString *const queryKey;
extern NSString *const fromKey;
extern NSString *const sortByKey;
extern NSString *const apiKey;

@interface FetchGoogleNews : NSObject

-(void)fetchGoogleNews:(NSString *)query fromDate:(NSString*)dateString sortBy:(NSString*)sortBy;

@end
