//
//  WebserverCommunicator.h
//  GNewsFeed
//
//  Created by Ganesh Amrule on 28/11/23.
//

#import <Foundation/Foundation.h>

typedef void (^ successBlock)(BOOL, NSDictionary*);
typedef void (^ failureBlock)(BOOL, NSError*);

@interface WebserverCommunicator : NSObject {
    NSMutableData *_responseData;
    NSString *baseURL;
}

-(void)sendAsyncRequest: (NSString*)requestType
                 params:(NSDictionary *)params
            sucessBlock:(successBlock)successBlock
              failBlock:(failureBlock)failureBlock;

@end
