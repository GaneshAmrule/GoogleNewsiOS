//
//  NewsFeedCell.h
//  GNewsFeed
//
//  Created by Ganesh Amrule on 28/11/23.
//

#import <UIKit/UIKit.h>

@interface NewsFeedCell : UITableViewCell

-(void)initWithDetails:(NSString*)imagePath
          title:(NSString*)title
    description:(NSString*)description
                  date:(NSString*)date;

@end
