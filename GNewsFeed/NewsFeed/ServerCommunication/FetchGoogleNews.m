//
//  FetchGoogleNews.m
//  GNewsFeed
//
//  Created by Ganesh Amrule on 28/11/23.
//

#import "FetchGoogleNews.h"
#import "WebserverCommunicator.h"

#define kgoogleNewsAPIKey @"cf0d7577c11e4efab8d36d4ecdcc30ae"
NSString *const queryKey = @"q";
NSString *const fromKey = @"from";
NSString *const sortByKey = @"sortBy";
NSString *const apiKey = @"apiKey";
NSString *const getReq = @"GET";


@implementation FetchGoogleNews

-(void)fetchGoogleNews:(NSString *)query fromDate:(NSString*)dateString sortBy:(NSString*)sortBy {
    NSDictionary *paramsDictionary = @ {queryKey:query, fromKey: dateString, sortByKey:sortBy, apiKey:kgoogleNewsAPIKey};
    WebserverCommunicator *webserverCom = [[WebserverCommunicator alloc] init];
    [webserverCom sendAsyncRequest:getReq params:paramsDictionary];
    
}

@end
