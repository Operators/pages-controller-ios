//
//  ReelContentGroup.h
//  SwipesObjCExamples
//
//  Created by Christopher Miller on 7/21/15.
//  Copyright (c) 2015 The MAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ReelContentGroup : UIControl

@property (strong, nonatomic) UIButton *mImdbView;
@property (strong, nonatomic) UITextView *mDescription;
@property (strong, nonatomic) NSString *mReelId;

-(void) setupViewWithConvenienceMethods;
-(void) setReelDescription:(NSString*)desc;

@end