//
//  FeedListController.m
//  GNewsFeed
//
//  Created by Ganesh Amrule on 28/11/23.
//

#import "FeedListController.h"
#import "FeedDetailsViewController.h"
#import "NewsFeedCell.h"
#import "FeedData.h"

@interface FeedListController ()

@end

@implementation FeedListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = true;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
}

-(void)displayFeedDetails:(FeedData*)feedData {
    FeedDetailsViewController *feedDetailVC = [FeedDetailsViewController instantiateVc:feedData];
    [self.navigationController pushViewController:feedDetailVC animated:true];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.feedArticles.articles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"FeedCell";
       NewsFeedCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
       if (cell == nil) {
           cell = [[NewsFeedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
       }
    FeedData *feedData = [self.feedArticles.articles objectAtIndex:indexPath.row];
    [cell initWithFeedData:feedData];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FeedData *feedData = [self.feedArticles.articles objectAtIndex:indexPath.row];
    [self displayFeedDetails:feedData];
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return UITableViewAutomaticDimension;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return UITableViewAutomaticDimension;
}
@end
