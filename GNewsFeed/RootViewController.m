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

@interface RootViewController ()
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *fetchNewsLabel;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchGoogleNews];
}

-(void)displayNewsFeed:(FeedArticles *)articles {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FeedListController *feedListVC = [sb instantiateViewControllerWithIdentifier:@"FeedList"];
    feedListVC.feedArticles = articles;
    [self.navigationController pushViewController:feedListVC animated:true];
}

-(void)fetchGoogleNews {
    [self.activityIndicator startAnimating];
    FetchGoogleNews *googleNews = [[FetchGoogleNews alloc] init];
    [googleNews fetchGoogleNews:@"bitcon" fromDate:@"2023-10-28" sortBy:@"popularity" completionBlock:^(NSError *error, FeedArticles *articles){
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.activityIndicator stopAnimating];
            [self.activityIndicator removeFromSuperview];
            self.activityIndicator = nil;
            [self.fetchNewsLabel removeFromSuperview];
            self.fetchNewsLabel = nil;
            
            if (error ==nil & articles!= nil & articles.articles.count > 0) {
                [self displayNewsFeed:articles];
            }
        });
    }];
}

@end
