//
//  ViewController.m
//  GNewsFeed
//
//  Created by Ganesh Amrule on 28/11/23.
//

#import "ViewController.h"
#import "FeedListController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self displayNewsFeed];
}

-(void)displayNewsFeed {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FeedListController *feedListVC = [sb instantiateViewControllerWithIdentifier:@"FeedList"];
    [self.navigationController pushViewController:feedListVC animated:true];
}

@end
