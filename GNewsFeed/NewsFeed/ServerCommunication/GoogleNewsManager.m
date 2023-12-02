//
//  GoogleNewsManager.m
//  GNewsFeed
//
//  Created by Ganesh Amrule on 30/11/23.
//

#import "GoogleNewsManager.h"

#define NEWS_PAGE_SIZE 10

@interface GoogleNewsManager()

@property (atomic, strong) NSMutableArray *articlesList;
@property (atomic, assign) int currentPageNo;

@end

@implementation GoogleNewsManager

+(GoogleNewsManager*)sharedInstance {
    static GoogleNewsManager *sharedManager = nil;
       static dispatch_once_t onceToken;
       dispatch_once(&onceToken, ^{
           sharedManager = [[self alloc] init];
     });
     return sharedManager;
}

- (GoogleNewsManager *)init {
    if (self = [super init]) {
        self.currentPageNo = 1;
        self.hasNextPage = true;
        self.hasPreviousPage = false;
        self.articlesList = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)fetchPrevNewsPage:(NSString*)query
                fromDate:(NSString*)fromDate
                  sortBy:(NSString *)sortBy
         completionBlock:(pageCompletionBlock)completionBlock {
    
    @synchronized (self) {
        if (self.currentPageNo == 1) {
            self.hasPreviousPage = false;
            return;
        }
        
        FetchGoogleNews *googleNews = [[FetchGoogleNews alloc] init];
        __weak GoogleNewsManager *weakSelf = self;
        
        [googleNews fetchGoogleNews:query
                           fromDate:fromDate
                             sortBy:sortBy
                             pageNo:self.currentPageNo -1
                           pageSize:NEWS_PAGE_SIZE
                    completionBlock:^(NSError *error, FeedArticles *articles) {
            
            if (error ==nil & articles!= nil & articles.articles.count > 0) {
                if (articles.articles.count < NEWS_PAGE_SIZE) {
                    weakSelf.hasPreviousPage = false;
                }
                NSRange range = NSMakeRange(0, [articles.articles count]);
                NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
                [self.articlesList insertObjects:articles.articles atIndexes:indexSet];
                if (self.articlesList.count > NEWS_PAGE_SIZE) {
                    [self removeLastPageArticles];
                }
                weakSelf.currentPageNo--;
                completionBlock(nil, self.articlesList,true);
            } else {
                completionBlock(error, nil,false);
            }
        }];
    }
}

-(void)fetchNextNewsPage:(NSString*)query
                fromDate:(NSString*)fromDate
                  sortBy:(NSString *)sortBy
         completionBlock:(pageCompletionBlock)completionBlock {
    
    @synchronized (self) {
        
        FetchGoogleNews *googleNews = [[FetchGoogleNews alloc] init];
        __weak GoogleNewsManager *weakSelf = self;
        
        [googleNews fetchGoogleNews:query
                           fromDate:fromDate
                             sortBy:sortBy
                             pageNo:self.currentPageNo
                           pageSize:NEWS_PAGE_SIZE
                    completionBlock:^(NSError *error, FeedArticles *articles) {
            
            if (error ==nil & articles!= nil & articles.articles.count > 0) {
                if (articles.articles.count < NEWS_PAGE_SIZE) {
                    weakSelf.hasNextPage = false;
                }
                int startIndex = (int)self.articlesList.count;
                NSRange range = NSMakeRange(startIndex, articles.articles.count);
                NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
                [self.articlesList insertObjects:articles.articles atIndexes:indexSet];
                weakSelf.currentPageNo++;
                
                if (self.articlesList.count > NEWS_PAGE_SIZE) {
                    [self removeFirstPageArticles];
                }
                
                completionBlock(nil, self.articlesList,true);
            } else {
                completionBlock(error, nil, false);
            }
        }];
    }
}

-(void)removeFirstPageArticles {
    @synchronized (self.articlesList) {
        if (self.articlesList.count > NEWS_PAGE_SIZE ) {
            NSRange range = NSMakeRange(0, NEWS_PAGE_SIZE);
            [self.articlesList removeObjectsInRange:range];
            [self updateHasPreviousPage];
        }
    }
}

-(void)removeLastPageArticles {
    @synchronized (self.articlesList) {
        if (self.articlesList.count > NEWS_PAGE_SIZE ) {
            NSRange range = NSMakeRange(self.articlesList.count-NEWS_PAGE_SIZE, NEWS_PAGE_SIZE);
            [self.articlesList removeObjectsInRange:range];
             self.hasNextPage = true;
            [self updateHasPreviousPage];
        }
    }
}

-(void)updateHasPreviousPage {
    self.currentPageNo == 1 ? (self.hasPreviousPage = false) : (self.hasPreviousPage = true);
}

@end
