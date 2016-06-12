//
//  YouTubePresenter.h
//  SwipesObjCExamples
//
//  Created by Christopher Miller on 7/21/15.
//  Copyright (c) 2015 The MAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YouTubePresenter : UIView <UIWebViewDelegate,UISwipesViewDelegate>

@property (weak, nonatomic) NSString *mTrailer;
@property (strong, nonatomic) UIImageView *mImagePreview;
@property (strong, nonatomic) UIWebView *mCurrentPreview;

-(void) setUpTrailer:(NSString*)t;

-(void) setupViewWithConvenienceMethods;
-(BOOL) hasTrailer;
-(void) reset;

@end