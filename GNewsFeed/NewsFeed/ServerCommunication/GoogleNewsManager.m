//
//  GoogleNewsManager.m
//  GNewsFeed
//
//  Created by Ganesh Amrule on 30/11/23.
//

#import "GoogleNewsManager.h"

#define NEWS_PAGE_SIZE 10

@interface GoogleNewsManager()

@property (nonatomic, strong) NSMutableArray *articlesList;
@property (nonatomic, assign) int topCurrentPageNo;
@property (nonatomic, assign) int buttomCurrentPageNo;
@property (nonatomic, assign) FetchDirection currentFetchDirection;

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
        self.topCurrentPageNo = 1;
        self.buttomCurrentPageNo = 0;
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
    
    if (self.topCurrentPageNo == 1) {
        self.hasPreviousPage = false;
    }
    
    self.currentFetchDirection = FETCH_PREVIOUS;
    
    FetchGoogleNews *googleNews = [[FetchGoogleNews alloc] init];
    __weak GoogleNewsManager *weakSelf = self;
    
    [googleNews fetchGoogleNews:query
                       fromDate:fromDate
                         sortBy:sortBy
                         pageNo:(self.topCurrentPageNo - 1)
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
            weakSelf.topCurrentPageNo -=1;
            completionBlock(nil, self.articlesList,true);
        } else {
            completionBlock(error, nil,false);
        }
    }];
}

-(void)fetchNextNewsPage:(NSString*)query
                fromDate:(NSString*)fromDate
                  sortBy:(NSString *)sortBy
         completionBlock:(pageCompletionBlock)completionBlock {
    
    self.currentFetchDirection = FETCH_NEXT;
    
    FetchGoogleNews *googleNews = [[FetchGoogleNews alloc] init];
    __weak GoogleNewsManager *weakSelf = self;
    
    [googleNews fetchGoogleNews:query
                       fromDate:fromDate
                         sortBy:sortBy
                         pageNo:(self.buttomCurrentPageNo + 1)
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
            weakSelf.buttomCurrentPageNo += 1;
            
            if (self.articlesList.count > NEWS_PAGE_SIZE) {
                [self removeFirstPageArticles];
            }
            
            completionBlock(nil, self.articlesList,true);
        } else {
            completionBlock(error, nil, false);
        }
    }];
}

-(void)removeFirstPageArticles {
    if (self.articlesList.count > NEWS_PAGE_SIZE ) {
        NSRange range = NSMakeRange(0, NEWS_PAGE_SIZE);
        [self.articlesList removeObjectsInRange:range];
        self.topCurrentPageNo++;
        self.hasPreviousPage = true;
    }
}

-(void)removeLastPageArticles {
    if (self.articlesList.count > NEWS_PAGE_SIZE ) {
        NSRange range = NSMakeRange(self.articlesList.count-NEWS_PAGE_SIZE, NEWS_PAGE_SIZE);
        [self.articlesList removeObjectsInRange:range];
        self.topCurrentPageNo--;
        self.hasNextPage = true;
    }
}


@end
