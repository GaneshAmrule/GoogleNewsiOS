//
//  ImageDownloader.m
//  GNewsFeed
//
//  Created by Ganesh Amrule on 28/11/23.
//

#import "ImageDownloader.h"

@implementation ImageDownloader

- (void)downloadImage:(NSString *)url
   imageDownloadBlock:(imageDownloadBlock)imageDownloadBlock {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                   ^{
        NSURL *imageURL = [NSURL URLWithString:url];
        if (imageURL !=nil) {
            NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                imageDownloadBlock(imageData);
                
            });
        }
    });
}

@end
