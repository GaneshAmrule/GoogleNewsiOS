//
//  RootViewController.m
//  GNewsFeed
//
//  Created by Ganesh Amrule on 28/11/23.
//

#import "RootViewController.h"
#import "FeedListController.h"
#import "WebserverCommunicator.h"
#import "FetchGoogleNews.h"
#import "FeedArticles.h"
#import "GoogleNewsManager.h"
#import "Utility.h"

@interface RootViewController ()
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *fetchNewsLabel;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchGoogleNews];
}

-(void)displayNewsFeed:(NSArray *)articles {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FeedListController *feedListVC = [storyboard instantiateViewControllerWithIdentifier:@"FeedList"];
    feedListVC.feedArticles = articles;
    [self.navigationController pushViewController:feedListVC animated:true];
}

-(void)fetchGoogleNews {
    [self.activityIndicator startAnimating];
    
    GoogleNewsManager *newsManager = [GoogleNewsManager sharedInstance];
    [newsManager fetchNextNewsPage:@"market"
                          fromDate:@"23-11-1"
                            sortBy:@"popularity"
                   completionBlock:^(NSError *error, NSArray *articles, BOOL refresh){
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self removeProgressView];
            if (error ==nil & articles!= nil & articles.count > 0) {
                [self displayNewsFeed:articles];
            } else {
                [self displayError:error];
            }
        });
    }];
}

-(void)removeProgressView {
    [self.activityIndicator stopAnimating];
    [self.activityIndicator removeFromSuperview];
    self.activityIndicator = nil;
    
    [self.fetchNewsLabel removeFromSuperview];
    self.fetchNewsLabel = nil;
}

-(void)displayError:(NSError*)error {
    [Utility displayError:error onVC:self];
}

@end
