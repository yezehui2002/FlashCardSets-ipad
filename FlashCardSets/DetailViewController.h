//
//  DetailViewController.h
//  FlashCardSets
//
//  Created by Douglas Mason on 6/26/11.
//  Copyright 2011 DeveloperDoug. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface DetailViewController : UIViewController <UIPopoverControllerDelegate, UISplitViewControllerDelegate> {
    
}

@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;

@property (nonatomic, assign) IBOutlet RootViewController *rootViewController;

@end
