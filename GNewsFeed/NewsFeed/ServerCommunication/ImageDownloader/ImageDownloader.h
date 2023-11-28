//
//  ImageDownloader.h
//  GNewsFeed
//
//  Created by Ganesh Amrule on 28/11/23.
//

#import <Foundation/Foundation.h>

typedef void (^ imageDownloadBlock)(NSData*);

@interface ImageDownloader : NSObject
- (void)downloadImage:(NSString *)url
   imageDownloadBlock:(imageDownloadBlock)imageDownloadBlock;

@end

