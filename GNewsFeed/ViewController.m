//
//  ViewController.m
//  GNewsFeed
//
//  Created by Ganesh Amrule on 28/11/23.
//

#import "ViewController.h"
#import "FeedListController.h"
#import "WebserverCommunicator.h"
#import "FetchGoogleNews.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchGoogleNews];
    [self displayNewsFeed];
}

-(void)displayNewsFeed {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FeedListController *feedListVC = [sb instantiateViewControllerWithIdentifier:@"FeedList"];
    [self.navigationController pushViewController:feedListVC animated:true];
}

-(void)fetchGoogleNews {
    FetchGoogleNews *googleNews = [[FetchGoogleNews alloc] init];
    [googleNews fetchGoogleNews:@"bitcon" fromDate:@"2023-10-28" sortBy:@"popularity"];
}

@end
