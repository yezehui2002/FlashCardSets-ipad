//
//  CardGridViewCell.h
//  FlashCardSets
//
//  Created by Douglas Mason on 7/16/11.
//  Copyright 2011 DeveloperDoug. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AQGridViewCell.h"

@interface CardGridViewCell : AQGridViewCell {
    UIImageView *_imageView;
}

@property (nonatomic, retain) UIImage *image;

@end
