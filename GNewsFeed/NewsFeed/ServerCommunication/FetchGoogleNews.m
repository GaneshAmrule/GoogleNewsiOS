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
#import "NSDictionary+SafeObject.h"

#define kgoogleNewsAPIKey @"cf0d7577c11e4efab8d36d4ecdcc30ae"
NSString *const queryKey = @"q";
NSString *const fromKey = @"from";
NSString *const sortByKey = @"sortBy";
NSString *const apiKey = @"apiKey";
NSString *const getReq = @"GET";
NSString *const pageNoKey = @"page";
NSString *const pageSizeKey = @"pageSize";

@interface FetchGoogleNews()
{
    completionBlock completionHandler;
}
@end
@implementation FetchGoogleNews

-(void)fetchGoogleNews:(NSString *)query
              fromDate:(NSString*)dateString
                sortBy:(NSString*)sortBy
                pageNo:(NSInteger)pageNo
              pageSize:(NSInteger)pageSize
       completionBlock:(completionBlock)completionBlock {
    
    completionHandler = completionBlock;
    NSDictionary *paramsDictionary = @ {queryKey:query,
        fromKey: dateString,
        sortByKey:sortBy,
        apiKey:kgoogleNewsAPIKey,
        pageNoKey: [NSString stringWithFormat:@"%ld",pageNo],
        pageSizeKey:[NSString stringWithFormat:@"%ld",pageSize]
    };
    
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
    NSArray *articlesDict = [jsonDictionary safeObjectForKey:@"articles"];
    if (articlesDict == nil) {
        FeedError *error = [self parseFeedError:jsonDictionary];
        completionHandler(error, nil);
        return nil;
    }
    for (NSDictionary *article in articlesDict) {
        FeedSource *feedSource = [[FeedSource alloc] init];
        NSDictionary *feedSourceDict = [article safeObjectForKey:@"source"];
        feedSource.feedId = [feedSourceDict safeObjectForKey:@"id"];
        feedSource.name = [feedSourceDict safeObjectForKey:@"name"];
        
        FeedData *feedData = [[FeedData alloc] init];
        feedData.source = feedSource;
        feedData.author = [article safeObjectForKey:@"author"];
        feedData.title = [article safeObjectForKey:@"title"];
        feedData.feedDescription = [article safeObjectForKey:@"description"];
        feedData.url = [article safeObjectForKey:@"url"];
        feedData.urlToImage = [article safeObjectForKey:@"urlToImage"];
        feedData.publishedAt = [article safeObjectForKey:@"publishedAt"];
        feedData.content = [article safeObjectForKey:@"content"];
        [articleList addObject:feedData];
    }
    FeedArticles *feedArticles = [[FeedArticles alloc] init];
    feedArticles.articles = articleList;
    return feedArticles;
}

-(FeedError*)parseFeedError:(NSDictionary *)errorDictionary {
    FeedError *feedError = [[FeedError alloc] init];
    feedError.feedErrorCode = [errorDictionary safeObjectForKey:@"code"];
    feedError.message = [errorDictionary safeObjectForKey:@"message"];
    feedError.status = [errorDictionary safeObjectForKey:@"status"];
    return feedError;
}

@end
