//
//  PersistencyManager.m
//  iOS-Design-Patterns
//
//  Created by Crazyfree on 12/12/15.
//  Copyright © 2015 Crazyfree. All rights reserved.
//

#import "PersistencyManager.h"

@implementation PersistencyManager
{
    // an array of all albums
    NSMutableArray *books;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Try loading data from archivement
        NSData *data = [NSData dataWithContentsOfFile:[NSHomeDirectory() stringByAppendingString:@"/Documents/books.bin"]];
        NSLog(@"%@", NSHomeDirectory());
        books = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        if (books == nil) {
            books = [NSMutableArray arrayWithArray:
                     @[[[Book alloc] initWithTitle:@"Clean Code"
                                            author:@"Robert C. Martin"
                                          coverUrl:@"http://ecx.images-amazon.com/images/I/51oXyW8WQwL._SX258_BO1,204,203,200_.jpg"
                                              year:@"2009"],
                       
                       [[Book alloc] initWithTitle:@"Design Patterns"
                                            author:@"Gang of Four"
                                          coverUrl:@"http://blog.codinghorror.com/content/images/uploads/2007/07/6a0120a85dcdae970b012877701400970c-pi.png"
                                              year:@"1994"],
                       
                       [[Book alloc] initWithTitle:@"The Psychology of Problem Solving"
                                            author:@"Robert J. Sternberg PhD"
                                          coverUrl:@"http://assets.cambridge.org/97805217/97412/cover/9780521797412.jpg"
                                              year:@"2003"],
                       
                       [[Book alloc] initWithTitle:@"iOS 9 by Tutorials"
                                            author:@"James Frost and friends"
                                          coverUrl:@"http://cdn1.raywenderlich.com/wp-content/themes/raywenderlich/images/store-2015/small/i9T_cover@2x.png"
                                              year:@"2015"],
                       
                       [[Book alloc] initWithTitle:@"iOS Animations by Tutorials"
                                            author:@"Marin Todorov"
                                          coverUrl:@"http://cdn5.raywenderlich.com/wp-content/themes/raywenderlich/images/store-2015/small/iAT_cover@2x.png"
                                              year:@"2015"]]];
            [self saveBooks];
        }
    }
    return self;
}

- (NSArray*)getBooks
{
    return books;
}

- (void)addBook:(Book *)book atIndex:(int)index
{
    if (books.count >= index)
        [books insertObject:book atIndex:index];
    else
        [books addObject:book];
}

- (void)deleteBookAtIndex:(int)index
{
    [books removeObjectAtIndex:index];
}

- (void)saveImage:(UIImage *)image filename:(NSString *)filename
{
    filename = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@", filename];
    NSData *data = UIImagePNGRepresentation(image);
    [data writeToFile:filename atomically:YES];
}

- (UIImage *)getImage:(NSString *)filename
{
    filename = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@", filename];
    NSData *data = [NSData dataWithContentsOfFile:filename];
    return [UIImage imageWithData:data];
}

- (void)saveBooks
{
    NSString *filename = [NSHomeDirectory() stringByAppendingString:@"/Documents/books.bin"];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:books];
    [data writeToFile:filename atomically:YES];
}
@end
