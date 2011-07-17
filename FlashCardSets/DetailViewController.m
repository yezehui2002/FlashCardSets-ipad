//
//  DetailViewController.m
//  FlashCardSets
//
//  Created by Douglas Mason on 6/26/11.
//  Copyright 2011 DeveloperDoug. All rights reserved.
//

#import "DetailViewController.h"
#import "RootViewController.h"
#import "TestGridViewCell.h"

@interface DetailViewController ()
@property (nonatomic, retain) UIPopoverController *popoverController;
- (void) orientationChanged:(id)sender;
@end

@implementation DetailViewController

@synthesize toolbar = _toolbar;
@synthesize popoverController = _myPopoverController;
@synthesize gridView = _gridView;

- (void) dealloc {
    [_myPopoverController release];
    [_cardViews release];
    [_gridView release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.gridView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.gridView.autoresizesSubviews = YES;
    self.gridView.delegate = self;
    self.gridView.dataSource = self;
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    NSMutableArray *all = [[NSMutableArray alloc] init];
    
    NSArray *paths = [NSBundle pathsForResourcesOfType:@"png" inDirectory:[[NSBundle mainBundle] bundlePath]];
    
    for (NSString *path in paths) {
        //NSLog(@"%@", [NSString stringWithFormat:@"Path: %@", path]);
        if ( [[path lastPathComponent] hasPrefix:@"AQ"] )
            continue;
        
        [all addObject:path];
    }
    
    _cardViews = [all copy];
    
    [all release];
    
    [self.gridView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    //NSLog(@"%@", NSStringFromSelector(_cmd));
    //NSLog(@"%@", [NSString stringWithFormat:@"self.interfaceOrientation: %@", (self.interfaceOrientation == UIInterfaceOrientationPortrait) ? @"Portrait" : @"Landscape"]);
    
    if (UIInterfaceOrientationIsLandscape(fromInterfaceOrientation))
    {
        splitViewController.vertical = YES;
        
        if (![splitViewController isShowingMaster]) {
            [splitViewController toggleMasterView:self];
        }
        
        [splitViewController toggleSplitOrientation:self];
    }
    
    if (UIInterfaceOrientationIsPortrait(fromInterfaceOrientation))
    {
        splitViewController.vertical = NO;
        
        if (![splitViewController isShowingMaster]) {
            [splitViewController toggleMasterView:self];
        }
        
        [splitViewController toggleSplitOrientation:self];
    }
    
}

#pragma mark - Split view support

- (void)splitViewController:(MGSplitViewController*)svc 
	 willHideViewController:(UIViewController *)aViewController 
		  withBarButtonItem:(UIBarButtonItem*)barButtonItem 
	   forPopoverController: (UIPopoverController*)pc
{
	//NSLog(@"%@", NSStringFromSelector(_cmd));
	
	if (barButtonItem) {
		barButtonItem.title = @"Popover";
		NSMutableArray *items = [[self.toolbar items] mutableCopy];
		[items insertObject:barButtonItem atIndex:0];
		[self.toolbar setItems:items animated:YES];
		[items release];
	}
    self.popoverController = pc;
}


// Called when the view is shown again in the split view, invalidating the button and popover controller.
- (void)splitViewController:(MGSplitViewController*)svc 
	 willShowViewController:(UIViewController *)aViewController 
  invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
	//NSLog(@"%@", NSStringFromSelector(_cmd));
	
	if (barButtonItem) {
		NSMutableArray *items = [[self.toolbar items] mutableCopy];
		[items removeObject:barButtonItem];
		[self.toolbar setItems:items animated:YES];
		[items release];
	}
    self.popoverController = nil;
}


- (void)splitViewController:(MGSplitViewController*)svc 
		  popoverController:(UIPopoverController*)pc 
  willPresentViewController:(UIViewController *)aViewController
{
	//NSLog(@"%@", NSStringFromSelector(_cmd));
}


- (void)splitViewController:(MGSplitViewController*)svc willChangeSplitOrientationToVertical:(BOOL)isVertical
{
	//NSLog(@"%@", NSStringFromSelector(_cmd));
}


- (void)splitViewController:(MGSplitViewController*)svc willMoveSplitToPosition:(float)position
{
	//NSLog(@"%@", NSStringFromSelector(_cmd));
}


- (float)splitViewController:(MGSplitViewController *)svc constrainSplitPosition:(float)proposedPosition splitViewSize:(CGSize)viewSize
{
	//NSLog(@"%@", NSStringFromSelector(_cmd));
	return proposedPosition;
}

#pragma mark -
#pragma mark Grid View Methods

- (NSUInteger) numberOfItemsInGridView:(AQGridView *)gridView {
    return ( [_cardViews count] );
}

- (AQGridViewCell *) gridView:(AQGridView *)aGridView cellForItemAtIndex:(NSUInteger)index {
    
    static NSString *plainCellIdentifier = @"planCellIdentifier";
    
    AQGridViewCell *cell = nil;
    
    TestGridViewCell *cardViewCell = (TestGridViewCell *)[aGridView dequeueReusableCellWithIdentifier:plainCellIdentifier];
    
    if ( cardViewCell == nil ) {
        cardViewCell = [[[TestGridViewCell alloc] initWithFrame:CGRectMake(0.0, 0.0, 200.0, 150.0) reuseIdentifier:plainCellIdentifier] autorelease];
        cardViewCell.selectionGlowColor = [UIColor blueColor];
    }
    
    //NSLog(@"%@", [NSString stringWithFormat:@"Image Path: %@", [_cardViews objectAtIndex:index]]);
    
    cardViewCell.image = [UIImage imageNamed:[_cardViews objectAtIndex:index]];
    
    cell = cardViewCell;
    
    return ( cell );
}

- (CGSize) portraitGridCellSizeForGridView:(AQGridView *)gridView {
    return CGSizeMake(224.0, 168.0);
}

#pragma mark -
#pragma mark Custom Instance Methods

- (void) configureView
{
    
}

- (void) orientationChanged:(id)sender
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    NSLog(@"%@", [NSString stringWithFormat:@"[[UIDevice currentDevice] orientation]: %@", ([[UIDevice currentDevice] orientation] == UIInterfaceOrientationPortrait) ? @"Portrait" : @"Landscape"]);
    
    if ([[UIDevice currentDevice] orientation] == UIInterfaceOrientationPortrait) {
        splitViewController.vertical = YES;
        
        if (![splitViewController isShowingMaster]) {
            [splitViewController toggleMasterView:self];
        }
        
        [splitViewController toggleSplitOrientation:self];
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}


































































@end
