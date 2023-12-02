//
//  NewsFeedCell.m
//  GNewsFeed
//
//  Created by Ganesh Amrule on 28/11/23.
//

#import "NewsFeedCell.h"
#import "ImageDownloader.h"

@interface NewsFeedCell()

@property (weak, nonatomic) IBOutlet UIImageView *feedImage;
@property (weak, nonatomic) IBOutlet UILabel *feedDate;
@property (weak, nonatomic) IBOutlet UILabel *feedTitle;
@property (weak, nonatomic) IBOutlet UILabel *feedDescription;

@property (strong, nonatomic) FeedData *feedData;

@end

@implementation NewsFeedCell


- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)initWithFeedData:(FeedData*)feedData {
    @try {
        self.feedData = feedData;
        self.feedTitle.text = feedData.title;
        self.feedDescription.text = feedData.feedDescription;
        self.feedDate.text = feedData.publishedAt;

        if (feedData.urlToImage != nil) {
            ImageDownloader *imageDownloader = [[ImageDownloader alloc] init];
            __weak NewsFeedCell *weakSelf = self;
            [imageDownloader downloadImage:feedData.urlToImage imageDownloadBlock:^(NSData *imageData){
                if (imageData != nil){
                    weakSelf.feedImage.image = [UIImage imageWithData:imageData];
                }
            }];
        }
    } @catch (NSException *exception) {
        NSLog(@"Failed to updated feed data");
    }
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
