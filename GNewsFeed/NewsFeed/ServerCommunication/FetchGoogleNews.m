//
//  FetchGoogleNews.m
//  GNewsFeed
//
//  Created by Ganesh Amrule on 28/11/23.
//

#import "FetchGoogleNews.h"
#import "WebserverCommunicator.h"
#import "FeedArticles.h"
#import "FeedData.h"
#import "FeedSource.h"

#define kgoogleNewsAPIKey @"cf0d7577c11e4efab8d36d4ecdcc30ae"
NSString *const queryKey = @"q";
NSString *const fromKey = @"from";
NSString *const sortByKey = @"sortBy";
NSString *const apiKey = @"apiKey";
NSString *const getReq = @"GET";


@implementation FetchGoogleNews

-(void)fetchGoogleNews:(NSString *)query
              fromDate:(NSString*)dateString
                sortBy:(NSString*)sortBy
       completionBlock:(completionBlock)completionBlock {
    
    NSDictionary *paramsDictionary = @ {queryKey:query, fromKey: dateString, sortByKey:sortBy, apiKey:kgoogleNewsAPIKey};
    WebserverCommunicator *webserverCom = [[WebserverCommunicator alloc] init];
    [webserverCom sendAsyncRequest:getReq params:paramsDictionary
                       sucessBlock:^(BOOL sucess, NSDictionary*data){
        if (sucess) {
            FeedArticles *articles = [self parseJson:data];
            completionBlock(nil, articles);
        }
    }
                         failBlock:^(BOOL success, NSError* error){
        completionBlock(error, nil);
    }];
}

-(FeedArticles*)parseJson:(NSDictionary *)jsonDictionary {
    NSMutableArray *articleList = [[NSMutableArray alloc] init];
    NSArray *articlesDict = [jsonDictionary valueForKey:@"articles"];
    if (articlesDict == nil) {
        return nil;
    }
    for (NSDictionary *article in articlesDict) {
        FeedSource *feedSource = [[FeedSource alloc] init];
        NSDictionary *feedSourceDict = [article valueForKey:@"source"];
        feedSource.feedId = [feedSourceDict valueForKey:@"id"];
        feedSource.name = [feedSourceDict valueForKey:@"name"];
        
        FeedData *feedData = [[FeedData alloc] init];
        feedData.source = feedSource;
        feedData.author = [article valueForKey:@"author"];
        feedData.title = [article valueForKey:@"title"];
        feedData.feedDescription = [article valueForKey:@"description"];
        feedData.url = [article valueForKey:@"url"];
        feedData.urlToImage = [article valueForKey:@"urlToImage"];
        feedData.publishedAt = [article valueForKey:@"publishedAt"];
        feedData.content = [article valueForKey:@"content"];
        [articleList addObject:feedData];
    }
    FeedArticles *feedArticles = [[FeedArticles alloc] init];
    feedArticles.articles = articleList;
    return feedArticles;
}

@end