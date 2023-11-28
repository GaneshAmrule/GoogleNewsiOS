//
//  FeedDetailsViewController.m
//  GNewsFeed
//
//  Created by Ganesh Amrule on 28/11/23.
//

#import "FeedDetailsViewController.h"
#import "ImageDownloader.h"

@interface FeedDetailsViewController ()

@property (nonatomic, strong) FeedData *feedData;
@property (weak, nonatomic) IBOutlet UIImageView *newsImage;
@property (weak, nonatomic) IBOutlet UILabel *newsContents;

@end

@implementation FeedDetailsViewController

+(FeedDetailsViewController*)instantiateVc:(FeedData *)feedData {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FeedDetailsViewController *feedDetailVC = [sb instantiateViewControllerWithIdentifier:@"FeedDetailsVC"];
    feedDetailVC.feedData = feedData;
    return feedDetailVC;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNewsData];
}

-(void)loadNewsData {
    self.newsContents.text = self.feedData.content;
    
    ImageDownloader *imageDownloader = [[ImageDownloader alloc] init];
    __weak FeedDetailsViewController *weakSelf = self;

    [imageDownloader downloadImage:self.feedData.urlToImage imageDownloadBlock:^(NSData *imageData){
        weakSelf.newsImage.image = [UIImage imageWithData:imageData];
    }];
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
    NSURL *newsURL = [NSURL URLWithString:self.feedData.url];
    [[UIApplication sharedApplication] openURL:newsURL options:@{} completionHandler:nil];
}

@end
