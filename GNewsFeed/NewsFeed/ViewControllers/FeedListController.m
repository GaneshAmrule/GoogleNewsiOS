//
//  FeedListController.m
//  GNewsFeed
//
//  Created by Ganesh Amrule on 28/11/23.
//

#import "FeedListController.h"
#import "FeedDetailsViewController.h"
#import "NewsFeedCell.h"

@interface FeedListController ()

@end

@implementation FeedListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = true;
}

-(void)displayFeedDetails:(NSInteger)index {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FeedDetailsViewController *feedDetailVC = [sb instantiateViewControllerWithIdentifier:@"FeedDetailsVC"];
    [self.navigationController pushViewController:feedDetailVC animated:true];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"FeedCell";
       NewsFeedCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
       if (cell == nil) {
           cell = [[NewsFeedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
       }
    [cell initWithDetails:@"" title:@"title" description:@"This is description" date:[NSString stringWithFormat:@"%ld",(long)indexPath.row]]; 
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self displayFeedDetails:indexPath.row];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
