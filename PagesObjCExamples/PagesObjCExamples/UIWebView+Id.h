//
//  NSDate+Format.h
//  Reel Life
//
//  Created by Christopher Miller on 9/3/15.
//  Copyright (c) 2015 The MAC. All rights reserved.
//

#ifndef Reel_Life_UIWebView_Id_h
#define Reel_Life_UIWebView_Id_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIWebView (Id)
@property (nonatomic, readonly) NSString *trailerId;
-(void) setTrailerId:(NSString *)trailerId;
@end

@interface NSLayoutConstraint (Extension)
+(NSArray*) constraintsWithVisualFormat:(NSString*)visualFormat views:(NSDictionary*)views;
+(NSArray*) constraintsWithVisualFormat:(NSString*)visualFormat metrics:(NSDictionary*)metrics views:(NSDictionary*)views;
+(NSArray*) constraintsWithVisualFormat:(NSString*)visualFormat options: (NSLayoutFormatOptions)options metrics:(NSDictionary*)metrics views:(NSDictionary*)views;
@end


@interface UIView (Extension)

-(NSArray*) stretchToBoundsOfSuperView;
-(NSArray*) alignTopTo:(UIView *)toItem padding:(CGFloat)padding;
-(NSArray*) centerHorizontallyTo:(UIView *)toItem;
-(NSArray*) centerHorizontallyTo:(UIView *)toItem padding:(CGFloat)padding;
-(NSArray*) centerVerticallyTo:(UIView *)toItem;
-(NSArray*) centerVerticallyTo:(UIView *)toItem padding:(CGFloat)padding;
-(NSArray*) stretchToWidthOfSuperView;
-(NSArray*) stretchToWidthOfSuperView:(CGFloat)padding;
-(NSArray*) stretchToHeightOfSuperView;
-(NSArray*) stretchToHeightOfSuperView:(CGFloat)padding;
-(NSArray*) constrainToTopOfSuperView:(CGFloat)padding;
-(NSArray*) constrainToLeftOfSuperView:(CGFloat)padding;
-(NSArray*) constrainToBottomOfSuperView:(CGFloat)padding;
-(NSArray*) constrainToRightOfSuperView:(CGFloat)padding;
-(NSArray*) constrainWidth:(CGFloat)width ;
-(NSArray*) constrainHeight:(CGFloat)height;
-(NSArray*) constrainWidthTo:(UIView *)toItem;
-(NSArray*) constrainHeightTo:(UIView *)toItem;
-(NSArray*) anchorToBottom:(UIView *)toItem padding:(CGFloat)padding;
-(NSArray*) anchorToRight:(UIView *)toItem padding:(CGFloat)padding;
-(NSArray*) anchorToTop:(UIView *)toItem padding:(CGFloat)padding;
-(NSArray*) anchorToLeft:(UIView *)toItem padding:(CGFloat)padding;

@end

#endif
