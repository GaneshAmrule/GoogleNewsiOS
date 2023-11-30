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
extern NSString *const pageNoKey;
extern NSString *const pageSizeKey;

typedef void (^ completionBlock)(NSError*, FeedArticles*);

@interface FetchGoogleNews : NSObject

-(void)fetchGoogleNews:(NSString *)query
              fromDate:(NSString*)dateString
                sortBy:(NSString*)sortBy
                pageNo:(NSInteger)pageNo
              pageSize:(NSInteger)pageSize
       completionBlock:(completionBlock)completionBlock;

@end
