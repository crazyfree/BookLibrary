//
//  ViewController.m
//  iOS-Design-Patterns
//
//  Created by Crazyfree on 12/12/15.
//  Copyright © 2015 Crazyfree. All rights reserved.
//

#import "ViewController.h"
#import "LibraryAPI.h"
#import "Book+TableRepresentation.h"
#import "HorizontalScroller.h"
#import "BookView.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, HorizontalScrollerDelegate>{
    UITableView *dataTable;
    NSArray *allBooks;
    NSDictionary *currentBookData;
    int currentBookIndex;
    HorizontalScroller *scroller;
    UIToolbar *toolbar;
    // We will use this array as a stack to push and pop operation for the undo option
    NSMutableArray *undoStack;

}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Change the background color to a nice navy blue color
    self.view.backgroundColor = [UIColor colorWithRed:0.76f green:0.81f blue:0.87f alpha:1];
    currentBookIndex = 0;
    
    // Add toolbar to screen
    toolbar = [[UIToolbar alloc] init];
    UIBarButtonItem *undoItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemUndo target:self action:@selector(undoAction)];
    undoItem.enabled = NO;
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *delete = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteBook)];
    [toolbar setItems:@[undoItem,space,delete]];
    [self.view addSubview:toolbar];
    undoStack = [[NSMutableArray alloc] init];
    
    // Get a list of all the albums via the API not PersistencyManager
    allBooks = [[LibraryAPI sharedInstance] getBooks];
    
    // the uitableview that presents the album data
    dataTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 120, self.view.frame.size.width, self.view.frame.size.height-120) style:UITableViewStyleGrouped];
    dataTable.delegate = self;
    dataTable.dataSource = self;
    dataTable.backgroundView = nil;
    [self.view addSubview:dataTable];
    
    [self showDataForBookAtIndex:currentBookIndex];

    // Load saved state
    [self loadPreviousState];
    
    // Init scoller
    scroller = [[HorizontalScroller alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 120)];
    scroller.backgroundColor = [UIColor colorWithRed:0.24f green:0.35f blue:0.49f alpha:1];
    scroller.delegate = self;
    [self.view addSubview:scroller];
    
    [self reloadScroller];
    
    // Add observer when application did enter background for saving current state
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveCurrentState) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

- (void)viewWillLayoutSubviews
{
    toolbar.frame = CGRectMake(0, self.view.frame.size.height-44, self.view.frame.size.width, 44);
    dataTable.frame = CGRectMake(0, 130, self.view.frame.size.width, self.view.frame.size.height - 200);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)showDataForBookAtIndex:(int)bookIndex
{
    // defensive code: make sure the requested index is lower than the amount of albums
    if (bookIndex < allBooks.count)
    {
        // fetch the album
        Book *book = allBooks[bookIndex];
        // save the albums data to present it later in the tableview
        currentBookData = [book tr_tableRepresentation];
    }
    else
    {
        currentBookData = nil;
    }
    
    // we have the data we need, let's refresh our tableview
    [dataTable reloadData];
}

- (void)reloadScroller
{
    allBooks = [[LibraryAPI sharedInstance] getBooks];
    if (currentBookIndex < 0) currentBookIndex = 0;
    else if (currentBookIndex >= allBooks.count) currentBookIndex = allBooks.count-1;
    [scroller reload];
    
    [self showDataForBookAtIndex:currentBookIndex];
}

- (void)addBook:(Book *)book atIndex:(int)index
{
    [[LibraryAPI sharedInstance] addBook:book atIndex:index];
    currentBookIndex = index;
    [self reloadScroller];
}

- (void)deleteBook
{
    // Get the album to delete
    Book *deletedBook = allBooks[currentBookIndex];
    
    // Create the NSInvocation, which will be used to reverse the delete action if the user later decides to undo a deletion.
    NSMethodSignature *sig = [self methodSignatureForSelector:@selector(addBook:atIndex:)];
    NSInvocation *undoAction = [NSInvocation invocationWithMethodSignature:sig];
    [undoAction setTarget:self];
    [undoAction setSelector:@selector(addBook:atIndex:)];
    [undoAction setArgument:&deletedBook atIndex:2];
    [undoAction setArgument:&currentBookIndex atIndex:3];
    [undoAction retainArguments];
    
    // Add undo action to stack
    [undoStack addObject:undoAction];
    
    // Delete selected Book and reload scroller
    [[LibraryAPI sharedInstance] deleteBookAtIndex:currentBookIndex];
    [self reloadScroller];
    
    // Enable toolbar undo button
    [toolbar.items[0] setEnabled:YES];
}

- (void)undoAction
{
    if (undoStack.count > 0)
    {
        NSInvocation *undoAction = [undoStack lastObject];
        [undoStack removeLastObject];
        [undoAction invoke];
    }
    
    if (undoStack.count == 0)
    {
        [toolbar.items[0] setEnabled:NO];
    }
}

#pragma mark - UITableView delegate and datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [currentBookData[@"titles"] count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = currentBookData[@"titles"][indexPath.row];
    cell.detailTextLabel.text = currentBookData[@"values"][indexPath.row];
    
    return cell;
}

#pragma mark - HorizontalScrollerDelegate methods
- (void)horizontalScroller:(HorizontalScroller *)scroller clickedViewAtIndex:(int)index
{
    currentBookIndex = index;
    [self showDataForBookAtIndex:index];
}

- (NSInteger)numberOfViewsForHorizontalScroller:(HorizontalScroller*)scroller
{
    return allBooks.count;
}

- (UIView*)horizontalScroller:(HorizontalScroller*)scroller viewAtIndex:(int)index
{
    Book *book = allBooks[index];
    return [[BookView alloc] initWithFrame:CGRectMake(0, 0, 100, 100) bookCover:book.coverUrl];
}

- (NSInteger)initialViewIndexForHorizontalScroller:(HorizontalScroller *)scroller
{
    return currentBookIndex;
}

#pragma mark - Save current state
- (void)saveCurrentState
{
    // When the user leaves the app and then comes back again, he wants it to be in the exact same state
    // he left it. In order to do this we need to save the currently displayed album.
    // Since it's only one piece of information we can use NSUserDefaults.
    [[NSUserDefaults standardUserDefaults] setInteger:currentBookIndex forKey:@"currentBookIndex"];
    [[LibraryAPI sharedInstance] saveBooks];
}

- (void)loadPreviousState
{
    currentBookIndex = [[NSUserDefaults standardUserDefaults] integerForKey:@"currentBookIndex"];
    [self showDataForBookAtIndex:currentBookIndex];
}

@end
