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
#import "GoogleNewsManager.h"
#import "Utility.h"

@interface FeedListController ()
{
    UIActivityIndicatorView *activityIndicator;
}

@property (assign, nonatomic) BOOL isFeedFetching;

@end

@implementation FeedListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = true;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.isFeedFetching = false;
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
    return [self.feedArticles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"FeedCell";
       NewsFeedCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
       if (cell == nil) {
           cell = [[NewsFeedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
       }
    FeedData *feedData = [self.feedArticles objectAtIndex:indexPath.row];
    [cell initWithFeedData:feedData];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FeedData *feedData = [self.feedArticles objectAtIndex:indexPath.row];
    [self displayFeedDetails:feedData];
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return UITableViewAutomaticDimension;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return UITableViewAutomaticDimension;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int height = scrollView.frame.size.height;
    int contentYOffset = scrollView.contentOffset.y;
    float distanceFromBottom = scrollView.contentSize.height - contentYOffset;
    
    if (contentYOffset <= 0) {
        NSLog(@"You reached top of the table");
        if ([[GoogleNewsManager sharedInstance] hasPreviousPage]) {
            [self fetchPreviousNews];
        }
    }
    if (distanceFromBottom < height) {
        NSLog(@"You reached end of the table");
        if ([[GoogleNewsManager sharedInstance] hasNextPage]) {
            [self fetchNextNews];
        }
    }
}

-(void)refreshTableview {
    [self.tableView reloadData];
}

-(void)fetchNextNews {
    GoogleNewsManager *newsManager = [GoogleNewsManager sharedInstance];
    [self showProgressCell:false];
    [newsManager fetchNextNewsPage:@"market"
                          fromDate:@"23-11-1"
                            sortBy:@"popularity"
                   completionBlock:^(NSError *error, NSArray *articles, BOOL refresh){
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self hideProgressCell];
            if (error ==nil & articles!= nil & articles.count > 0) {
                self.feedArticles = articles;
                [self refreshTableview];
            } else {
                [Utility displayError:error onVC:self];
            }
        });
    }];
}

-(void)fetchPreviousNews {
    [self showProgressCell:true];
    GoogleNewsManager *newsManager = [GoogleNewsManager sharedInstance];
    [newsManager fetchPrevNewsPage:@"market"
                          fromDate:@"23-11-1"
                            sortBy:@"popularity"
                   completionBlock:^(NSError *error, NSArray *articles, BOOL refresh){
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self hideProgressCell];
            if (error ==nil & articles!= nil & articles.count > 0) {
                self.feedArticles = articles;
                [self refreshTableview];
            } else {
                [Utility displayError:error onVC:self];
            }
        });
    }];
}

-(void)showProgressCell: (BOOL)bTop {
    
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleLarge];
    [activityIndicator startAnimating];
    activityIndicator.frame = CGRectMake(0.0, 0.0, self.tableView.frame.size.width, 100);
    if (bTop) {
        self.tableView.tableHeaderView = activityIndicator;
        self.tableView.tableHeaderView.hidden = false;
    } else {
        self.tableView.tableFooterView = activityIndicator;
        self.tableView.tableFooterView.hidden = false;
    }
}

-(void)hideProgressCell {
    
    if (activityIndicator!=nil) {
        [activityIndicator stopAnimating];
        [activityIndicator removeFromSuperview];
        activityIndicator = nil;
    }
    //Hide footer veiw
    self.tableView.tableFooterView.hidden = true;
    //Hide header view
    self.tableView.tableHeaderView = nil;
}

@end
