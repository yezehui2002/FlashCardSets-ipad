//
//  DetailViewController.h
//  FlashCardSets
//
//  Created by Douglas Mason on 6/26/11.
//  Copyright 2011 DeveloperDoug. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AQGridView.h"
#import "MGSplitViewController.h"

@interface DetailViewController : UIViewController <UIPopoverControllerDelegate, 
                                                    MGSplitViewControllerDelegate,
                                                    AQGridViewDelegate,
                                                    AQGridViewDataSource> 
{
    NSArray *_cardViews;
    AQGridView *_gridView;
    
@private
    IBOutlet MGSplitViewController *splitViewController;
}

@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;
@property (nonatomic, retain) IBOutlet AQGridView *gridView;

- (void) configureView;

@end
