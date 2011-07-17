//
//  TestGridViewCell.h
//  Test
//
//  Created by Douglas Mason on 7/16/11.
//  Copyright 2011 TEKSystems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AQGridViewCell.h"

@interface TestGridViewCell : AQGridViewCell 
{
    UIImageView *_imageView;
}

@property (nonatomic, retain) UIImage *image;

@end
