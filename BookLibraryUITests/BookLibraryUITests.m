//
//  iOS_Design_PatternsUITests.m
//  iOS-Design-PatternsUITests
//
//  Created by Crazyfree on 12/12/15.
//  Copyright © 2015 Crazyfree. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface BookLibraryUITests : XCTestCase

@end

@implementation BookLibraryUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testUI {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElementQuery *scrollViewsQuery = app.scrollViews;
    XCUIElementQuery *tableView = app.tables;
    [[[[scrollViewsQuery childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeImage].element tap];
    // Design patterns book tapped
    // Check book name equas Design Patterns
//    [[[tableView childrenMatchingType:XCUIElementTypeTableRow] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeTextView];
    
//    XCUIElementQuery *tableCellQuery = tableView.cells.staticTexts[@"Book name"];
    
//    XCUIElement *cellDetailTextLabel = [[[tableCellQuery childrenMatchingType:XCUIElementTypeTextView] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeCell].element;
//    XCTAssertEqual([cellDetailTextLabel label], @"Design Patterns");
    
    [[[[scrollViewsQuery childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:2] childrenMatchingType:XCUIElementTypeImage].element tap];
    // Design patterns book tapped
    // Check book name equas The Psychology of Problem Solving
    
    XCUIElement *image = [[[scrollViewsQuery childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:3] childrenMatchingType:XCUIElementTypeImage].element;
    [image tap];
    // Design patterns book tapped
    // Check book name equas iOS 9 by Tutorial
    
    XCUIElementQuery *toolbarsQuery = app.toolbars;
    // Delete iOS 9 by Tutorial
    XCUIElement *deleteButton = toolbarsQuery.buttons[@"Delete"];
    [deleteButton tap];
    // Delete The Psychology of Problem Solving
    [image tap];
    [deleteButton tap];
    
    XCUIElement *undoButton = toolbarsQuery.buttons[@"Undo"];
    // Undo The Psychology of Problem Solving
    [undoButton tap];
    // Undo iOS 9 by Tutorial
    [undoButton tap];
    
}

@end
