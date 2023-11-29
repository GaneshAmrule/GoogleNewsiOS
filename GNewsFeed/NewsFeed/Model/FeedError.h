//
//  FeedError.h
//  GNewsFeed
//
//  Created by Sagar Mane on 29/11/23.
//

#import <Foundation/Foundation.h>

@interface FeedError : NSError

@property (nonatomic, strong) NSString *feedErrorCode;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *status;

@end
