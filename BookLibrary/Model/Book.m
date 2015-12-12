//
//  Book.m
//  iOS-Design-Patterns
//
//  Created by Crazyfree on 12/12/15.
//  Copyright © 2015 Crazyfree. All rights reserved.
//

#import "Book.h"

@implementation Book

- (id)initWithTitle:(NSString*)title author:(NSString*)author coverUrl:(NSString*)coverUrl year:(NSString*)year
{
    self = [super init];
    if (self)
    {
        _title = title;
        _author = author;
        _coverUrl = coverUrl;
        _year = year;
        _category = @"IT";
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.year forKey:@"year"];
    [aCoder encodeObject:self.title forKey:@"album"];
    [aCoder encodeObject:self.author forKey:@"author"];
    [aCoder encodeObject:self.coverUrl forKey:@"cover_url"];
    [aCoder encodeObject:self.category forKey:@"category"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        _year       = [aDecoder decodeObjectForKey:@"year"];
        _title      = [aDecoder decodeObjectForKey:@"album"];
        _author     = [aDecoder decodeObjectForKey:@"author"];
        _coverUrl   = [aDecoder decodeObjectForKey:@"cover_url"];
        _category   = [aDecoder decodeObjectForKey:@"category"];
    }
    return self;
}
@end
