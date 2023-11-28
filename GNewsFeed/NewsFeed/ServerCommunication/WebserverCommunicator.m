//
//  WebserverCommunicator.m
//  GNewsFeed
//
//  Created by Ganesh Amrule on 28/11/23.
//

#import "WebserverCommunicator.h"

#define kgoogleNewsAPIHost @"https://newsapi.org/v2/everything"


@implementation WebserverCommunicator

-(void)sendAsyncRequest: (NSString*)requestType params:(NSDictionary *)params {
    // Send a synchronous request
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSString *urlString = [self createURLString:params];
    NSURL *url = [NSURL URLWithString:urlString];
    [request setURL:url];
    [request setHTTPMethod:requestType];
    [request addValue:@"text/plain" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"text/plain" forHTTPHeaderField:@"Accept"];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        NSData * responseData = [requestReply dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
        NSLog(@"requestReply: %@", jsonDict);
    }] resume];
}

-(NSString *)createURLString:(NSDictionary*)params {
    NSMutableString *urlString = [[NSMutableString alloc] initWithString:kgoogleNewsAPIHost];
    [urlString appendString:@"?"];
    BOOL firstParam = true;
    for (NSString* key in params.allKeys) {
        NSString *value = (NSString *)[params objectForKey:key];
        if (firstParam) {
            [urlString appendFormat:@"%@=%@", key, value];
            firstParam = false;
        } else {
            [urlString appendFormat:@"&%@=%@", key, value];
        }
    }
    return urlString;
}

@end
