//
//  RootViewController.h
//  FlashCardSets
//
//  Created by Douglas Mason on 6/26/11.
//  Copyright 2011 DeveloperDoug. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface RootViewController : UITableViewController {
    NSArray *_decks;
}

@property (nonatomic, retain) IBOutlet DetailViewController *detailViewController;

- (void) selectFirstRow;

@end
