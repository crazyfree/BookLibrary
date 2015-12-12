//
//  LibraryAPI.m
//  iOS-Design-Patterns
//
//  Created by Crazyfree on 12/12/15.
//  Copyright © 2015 Crazyfree. All rights reserved.
//

#import "LibraryAPI.h"
#import "PersistencyManager.h"
#import "HTTPClient.h"

@implementation LibraryAPI
{
    PersistencyManager *persistencyManager;
    HTTPClient *httpClient;
    BOOL isOnline;
}

+ (LibraryAPI *)sharedInstance
{
    // Declare a static variable to hold the instance
    static LibraryAPI *_sharedInstance = nil;
    
    // Ensures the initialization code executes only once.
    static dispatch_once_t oncePredicate;
    
    // The initializer is never called again once the class has been instantiated.
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[LibraryAPI alloc] init];
    });
    return _sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        persistencyManager = [[PersistencyManager alloc] init];
        httpClient = [[HTTPClient alloc] init];
        isOnline = NO;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadImage:) name:@"BLDownloadImageNotification" object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)downloadImage:(NSNotification *)notification
{
    // Get notification userinfo
    UIImageView *imageView = notification.userInfo[@"imageView"];
    NSString *coverUrl = notification.userInfo[@"coverUrl"];
    
    // Retrieve the image from the PersistencyManager if it’s been downloaded previously.
    imageView.image = [persistencyManager getImage:[coverUrl lastPathComponent]];
    
    if (imageView.image == nil)
    {
        // If the image hasn’t already been downloaded, then retrieve it using HTTPClient.
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIImage *image = [httpClient downloadImage:coverUrl];
            
            // Display the image in the image view and use the PersistencyManager to save it locally.
            dispatch_sync(dispatch_get_main_queue(), ^{
                imageView.image = image;
                [persistencyManager saveImage:image filename:[coverUrl lastPathComponent]];
            });
        });
    }
}

#pragma mark - PersistencyManager method here
- (NSArray*)getBooks
{
    return [persistencyManager getBooks];
}

- (void)addBook:(Book *)book atIndex:(int)index
{
    [persistencyManager addBook:book atIndex:index];
    if (isOnline)
    {
        [httpClient postRequest:@"/api/addAlbum" body:[book description]];
    }
}

- (void)deleteBookAtIndex:(int)index
{
    [persistencyManager deleteBookAtIndex:index];
    if (isOnline)
    {
        [httpClient postRequest:@"/api/deleteAlbum" body:[@(index) description]];
    }
}

- (void)saveBooks
{
    [persistencyManager saveBooks];
}
@end
