//
//  FeedDetailsViewController.h
//  GNewsFeed
//
//  Created by Ganesh Amrule on 28/11/23.
//

#import <UIKit/UIKit.h>
#import "FeedData.h"

@interface FeedDetailsViewController : UIViewController
+(FeedDetailsViewController*)instantiateVc:(FeedData *)feedData;
@end
