//
//  FeedListController.h
//  GNewsFeed
//
//  Created by Ganesh Amrule on 28/11/23.
//

#import <UIKit/UIKit.h>
#import "FeedArticles.h"


@interface FeedListController : UITableViewController
@property (nonatomic, strong) FeedArticles *feedArticles;
@end
