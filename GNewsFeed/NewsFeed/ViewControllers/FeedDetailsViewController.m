//
//  FeedDetailsViewController.m
//  GNewsFeed
//
//  Created by Ganesh Amrule on 28/11/23.
//

#import "FeedDetailsViewController.h"

@interface FeedDetailsViewController ()

@end

@implementation FeedDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.hidesBackButton = false;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationItem.hidesBackButton =true;
}

- (IBAction)openNews:(id)sender {
    NSURL *newsURL = [NSURL URLWithString:@"https://www.google.com"];
    [[UIApplication sharedApplication] openURL:newsURL options:@{} completionHandler:nil];
}

@end
