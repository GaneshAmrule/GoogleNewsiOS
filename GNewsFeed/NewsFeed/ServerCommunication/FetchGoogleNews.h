//
//  FetchGoogleNews.h
//  GNewsFeed
//
//  Created by Ganesh Amrule on 28/11/23.
//

#import <Foundation/Foundation.h>
#import "FeedArticles.h"
#import "FeedError.h"

extern NSString *const queryKey;
extern NSString *const fromKey;
extern NSString *const sortByKey;
extern NSString *const apiKey;

typedef void (^ completionBlock)(NSError*, FeedArticles*);

@interface FetchGoogleNews : NSObject

-(void)fetchGoogleNews:(NSString *)query
              fromDate:(NSString*)dateString
                sortBy:(NSString*)sortBy
       completionBlock:(completionBlock)completionBlock;

@end
