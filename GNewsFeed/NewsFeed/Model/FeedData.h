//
//  FeedData.h
//  GNewsFeed
//
//  Created by Ganesh Amrule on 28/11/23.
//

#import <Foundation/Foundation.h>
#import "FeedSource.h"

@interface FeedData : NSObject

@property (nonatomic, strong) FeedSource *source;
@property (nonatomic, strong) NSString* author;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString* feedDescription;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString* urlToImage;
@property (nonatomic, strong) NSString *publishedAt;
@property (nonatomic, strong) NSString* content;

@end
