//
//  Book.h
//  iOS-Design-Patterns
//
//  Created by Crazyfree on 12/12/15.
//  Copyright © 2015 Crazyfree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject <NSCoding>

@property (nonatomic, copy, readonly) NSString *title, *author, *category, *coverUrl, *year;

- (id)initWithTitle:(NSString*)title author:(NSString*)author coverUrl:(NSString*)coverUrl year:(NSString*)year;

@end
