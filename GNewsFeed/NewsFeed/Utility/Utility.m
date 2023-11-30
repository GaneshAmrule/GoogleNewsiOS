//
//  Utility.m
//  GNewsFeed
//
//  Created by Ganesh Amrule on 01/12/23.
//

#import "Utility.h"
#import "FeedError.h"

@implementation Utility

+(void)displayError:(NSError *)error onVC:(UIViewController *)viewController {
    UIAlertController *feedAlertVC = [[UIAlertController alloc] init];

    if ([error isKindOfClass:[FeedError class]]){
        feedAlertVC.title = [(FeedError*)error feedErrorCode];
        feedAlertVC.message = [(FeedError*)error message];
    } else {
        feedAlertVC.title = [NSString stringWithFormat:@"%ld", (long)[error code]];
        feedAlertVC.message = [error description];
    }
    UIAlertAction* okButton = [UIAlertAction
                                    actionWithTitle:@"Ok"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                    }];
    [feedAlertVC addAction:okButton];
    [viewController presentViewController:feedAlertVC animated:true completion:^{}];
}

@end
