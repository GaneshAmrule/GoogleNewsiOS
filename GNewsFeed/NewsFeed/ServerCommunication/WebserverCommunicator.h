//
//  WebserverCommunicator.h
//  GNewsFeed
//
//  Created by Ganesh Amrule on 28/11/23.
//

#import <Foundation/Foundation.h>


@interface WebserverCommunicator : NSObject {
    NSMutableData *_responseData;
    NSString *baseURL;
}

-(void)sendAsyncRequest: (NSString*)requestType params:(NSDictionary *)params;

@end
