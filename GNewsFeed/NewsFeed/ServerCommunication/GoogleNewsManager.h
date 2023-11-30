//
//  GoogleNewsManager.h
//  GNewsFeed
//
//  Created by Ganesh Amrule on 30/11/23.
//

#import <Foundation/Foundation.h>
#import "FetchGoogleNews.h"

typedef enum FetchDirectionType {
    FETCH_NEXT,
    FETCH_PREVIOUS
}FetchDirection;

typedef void (^ pageCompletionBlock)(NSError*, NSArray*, BOOL);


@interface GoogleNewsManager : NSObject

@property (nonatomic, assign) BOOL hasNextPage;
@property (nonatomic, assign) BOOL hasPreviousPage;

+(GoogleNewsManager*)sharedInstance;

-(void)fetchPrevNewsPage:(NSString*)query
                fromDate:(NSString*)fromDate
                  sortBy:(NSString *)sortBy
completionBlock:(pageCompletionBlock)completionBlock ;

-(void)fetchNextNewsPage:(NSString*)query
                fromDate:(NSString*)fromDate
                  sortBy:(NSString *)sortBy
completionBlock:(pageCompletionBlock)completionBlock ;

@end
