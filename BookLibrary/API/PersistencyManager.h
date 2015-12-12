//
//  PersistencyManager.h
//  iOS-Design-Patterns
//
//  Created by Crazyfree on 12/12/15.
//  Copyright © 2015 Crazyfree. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Book.h"

@interface PersistencyManager : NSObject

// Working with book array
- (NSArray *)getBooks;
- (void)addBook:(Book *)book atIndex:(int)index;
- (void)deleteBookAtIndex:(int)index;

// For downloading book cover image
- (void)saveImage:(UIImage *)image filename:(NSString *)filename;
- (UIImage *)getImage:(NSString *)filename;

// For archiving book
- (void)saveBooks;
@end
