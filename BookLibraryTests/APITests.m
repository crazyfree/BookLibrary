//
//  APITests.m
//  BookLibrary
//
//  Created by Crazyfree on 12/12/15.
//  Copyright © 2015 Crazyfree. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LibraryAPI.h"
#import "PersistencyManager.h"
#import "HTTPClient.h"
#include <stdlib.h>

@interface APITests : XCTestCase {
    LibraryAPI *api;
    int bookCount;
    NSArray *books;
    Book *book;
}

@end

@implementation APITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    api = [LibraryAPI sharedInstance];
//    NSError *error;
//    NSString *filePath = [NSHomeDirectory() stringByAppendingString:@"/Documents/books.bin"];
//    [[NSFileManager defaultManager] removeItemAtPath: filePath error:&error];
//    if(error){
//        NSLog(@"%@", [error localizedDescription]);
//    }
    books = [api getBooks];
    book = [books objectAtIndex:0];
    bookCount = books.count;
    NSLog(@"book count: %lu", books.count);
}

- (void)tearDown {
    api = nil;
    
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


- (void)testGetBookList{
    // In there we have to test download book but in my case doesn't have real server so we just test getting data from local
    XCTAssertEqual(books.count, 5);
}

- (void)testBookDeletes {
    [api deleteBookAtIndex:0];
    bookCount--;
    XCTAssertEqual(books.count, bookCount);
}

- (void) testBookAdds {
    [api addBook:book atIndex:0];
    bookCount++;
    XCTAssertEqual(books.count, bookCount);
}

- (void) testSaveBook {
    NSString *filePath = [NSHomeDirectory() stringByAppendingString:@"/Documents/books.bin"];
    XCTAssertTrue([[NSFileManager defaultManager] fileExistsAtPath:filePath]);
}

@end
