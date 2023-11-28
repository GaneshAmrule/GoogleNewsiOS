//
//  NewsFeedCell.m
//  GNewsFeed
//
//  Created by Ganesh Amrule on 28/11/23.
//

#import "NewsFeedCell.h"

@interface NewsFeedCell()

@property (weak, nonatomic) IBOutlet UIImageView *feedImage;
@property (weak, nonatomic) IBOutlet UILabel *feedDate;
@property (weak, nonatomic) IBOutlet UILabel *feedTitle;
@property (weak, nonatomic) IBOutlet UILabel *feedDescription;

@end

@implementation NewsFeedCell


- (void)awakeFromNib {
    [super awakeFromNib];
}
-(void)initWithDetails:(NSString*)imagePath
          title:(NSString*)title
    description:(NSString*)description
                  date:(NSString*)date {
    self.feedTitle.text = title;
    self.feedTitle.text = title;
    self.feedDescription.text = description;
    self.feedDate.text = date;
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
