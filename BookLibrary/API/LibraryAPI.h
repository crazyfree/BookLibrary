//
//  LibraryAPI.h
//  iOS-Design-Patterns
//
//  Created by Crazyfree on 12/12/15.
//  Copyright © 2015 Crazyfree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book.h"

@interface LibraryAPI : UIView
+ (LibraryAPI *)sharedInstance;

- (NSArray *)getBooks;
- (void)addBook:(Book *)book atIndex:(int)index;
- (void)deleteBookAtIndex:(int)index;
- (void)saveBooks;

@end
