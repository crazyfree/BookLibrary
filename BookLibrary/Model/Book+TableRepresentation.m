//
//  Book+TableRepresentation.m
//  iOS-Design-Patterns
//
//  Created by Crazyfree on 12/12/15.
//  Copyright © 2015 Crazyfree. All rights reserved.
//

#import "Book+TableRepresentation.h"

@implementation Book (TableRepresentation)

- (NSDictionary*)tr_tableRepresentation
{
    return @{@"titles":@[@"Author", @"Book name", @"Category", @"Year"],
             @"values":@[self.author, self.title, self.category, self.year]};
}

@end
