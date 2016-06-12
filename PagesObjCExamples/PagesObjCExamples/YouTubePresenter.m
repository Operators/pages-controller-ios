//
//  YouTubePresenter.m
//  SwipesObjCExamples
//
//  Created by Christopher Miller on 7/21/15.
//  Copyright (c) 2015 The MAC. All rights reserved.
//

#import <UISwipes/UISwipes.h>
#import "YouTubePresenter.h"
#import "UIWebView+Id.h"

@interface YouTubePresenter ()
@property (strong, nonatomic) UILabel *notSureLabel;
@property (strong, nonatomic) UILabel *laterLabel;
@property (strong, nonatomic) UILabel *watchedGoodLabel;
@property (strong, nonatomic) UILabel *watchedLabel;
@property (strong, nonatomic) Directions *direction;
@end

@implementation YouTubePresenter

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViewWithConvenienceMethods];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self setupViewWithConvenienceMethods];
    }
    return self;
}

-(void) setupViewWithConvenienceMethods {
    
    
    self.mCurrentPreview = [[UIWebView alloc] initWithFrame:self.frame];
    [self addSubview:self.mCurrentPreview];
    
    self.mImagePreview = [[UIImageView alloc] initWithFrame:self.frame];
    [self addSubview:self.mImagePreview];
    
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    if(DEBUG) self.backgroundColor = [UIColor clearColor];
    else  self.backgroundColor = [UIColor clearColor];
    
    self.mCurrentPreview.backgroundColor = [UIColor clearColor];
    [self.mCurrentPreview setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.mCurrentPreview setBackgroundColor:[UIColor clearColor]];
    [self.mCurrentPreview setOpaque:NO];
    [self.mCurrentPreview setAccessibilityLabel:@"Primary Trailer"];
    [self.mCurrentPreview setIsAccessibilityElement:YES];
    
    self.mCurrentPreview.scrollView.scrollEnabled = NO;
    self.mCurrentPreview.scrollView.bounces = NO;
    
    self.mImagePreview.backgroundColor = [UIColor blackColor];
    [self.mImagePreview setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.mImagePreview setBackgroundColor:[UIColor blackColor]];
    [self.mImagePreview setOpaque:NO];
    [self.mImagePreview setAccessibilityLabel:@"Secondary Trailer"];
    [self.mImagePreview setIsAccessibilityElement:YES];
    self.mImagePreview.alpha = 0.88f;
    
    CGFloat height = ([UIScreen mainScreen].bounds.size.height / 5) * 2;
    [self addConstraints:[self constrainHeight:height]];
    
    [self addConstraints:[self.mCurrentPreview constrainToTopOfSuperView:-27]];
    [self addConstraints:[self.mCurrentPreview stretchToWidthOfSuperView:0]];
    [self addConstraints:[self.mCurrentPreview constrainHeight:height + 23]];
    
    [self addConstraints:[self.mImagePreview constrainToTopOfSuperView:-27]];
    [self addConstraints:[self.mImagePreview stretchToWidthOfSuperView:0]];
    [self addConstraints:[self.mImagePreview constrainHeight:height + 23]];
    
    
    CGFloat width = self.bounds.size.width;
    CGFloat labelWidth = 140.f;
    CGFloat labelHeight = 60.f;
    
    self.notSureLabel = [self constructBorderedLabelInside:self.mImagePreview
                     withText:[NSLocalizedString(@"not sure", nil) uppercaseString]
                                                     color:[UIColor colorWithRed:255.f/255.f green:255.f/255.f blue:0.f/255.f alpha:1.f]
                                                     angle:15.f
                                                 andBounds:CGRectMake(width - labelWidth - 10.f, 40.f, labelWidth, labelHeight)];
    
    self.laterLabel = [self constructBorderedLabelInside:self.mImagePreview
                    withText:[NSLocalizedString(@"later", nil) uppercaseString]
                                                   color:[UIColor colorWithRed:135.f/255.f green:206.f/255.f blue:250.f/255.f alpha:1.f]
                                                   angle:-15.f
                                               andBounds:CGRectMake((width/2) - (labelWidth/2) - 10.f, 40.f, labelWidth, labelHeight)];
    
    self.watchedGoodLabel = [self constructBorderedLabelInside:self.mImagePreview
                             withText:[NSLocalizedString(@"watched", nil) uppercaseString]
                                                         color:[UIColor colorWithRed:29.f/255.f green:245.f/255.f blue:106.f/255.f alpha:1.f]
                                                         angle:-15.f
                                                     andBounds:CGRectMake(40.f, 40.f, labelWidth, labelHeight)];

    self.watchedLabel = [self constructBorderedLabelInside:self.mImagePreview
                         withText:[NSLocalizedString(@"watched", nil) uppercaseString]
                         color:[UIColor colorWithRed:247.f/255.f green:91.f/255.f blue:37.f/255.f alpha:1.f]
                                             angle:0.f
                                             andBounds:CGRectMake((width/2) - (labelWidth/2) - 10.f, self.bounds.size.height - labelHeight - 40.f, labelWidth, labelHeight)];
}

- (UILabel *)constructBorderedLabelInside:(UIImageView*)imageView
                                 withText:(NSString *)text
                                 color:(UIColor *)color
                                 angle:(CGFloat)angle
                                andBounds:(CGRect)bounds{
    
    UILabel *label = [[UILabel alloc] initWithFrame:bounds];
    label.text = [text uppercaseString];
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 2;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBlack"
                                 size:28.f];
    label.textColor = color;
    label.layer.borderColor = color.CGColor;
    label.layer.borderWidth = 5.f;
    label.layer.cornerRadius = 10.f;
    label.alpha = 0.f;
    
    [imageView addSubview:label];
    
    CGFloat conversion = angle * (3.141592/180.0);
    label.transform = CGAffineTransformRotate(CGAffineTransformIdentity, conversion);
    
    return label;
}

-(BOOL) hasTrailer { return self.mTrailer != nil; }

-(void) setUpTrailer:(NSString*)t {
    
    self.mTrailer = t;
    
    if([self hasTrailer]) {
        
        self.mCurrentPreview.trailerId = self.mTrailer;
        self.mCurrentPreview.hidden = NO;
        self.mImagePreview.hidden = YES;
        
        [self.mCurrentPreview setBackgroundColor:[UIColor clearColor]];
        [self.mCurrentPreview setOpaque:NO];
    } else {
        if(DEBUG) NSLog(@"%s %s The Trailer is missing!",__FILE__, __FUNCTION__);
    }
}

-(void) reset {
    
    self.mTrailer = nil;
}

- (void)onThresholdChange:(UISwipesViewCell*)card threshold:(CGFloat)threshold {
    
    if(![card isEqual:self.superview.superview]) return;
    
    if(threshold > 0.f && self.direction != nil) {
        self.mImagePreview.hidden = NO;
        self.mCurrentPreview.hidden = YES;
        self.mCurrentPreview.userInteractionEnabled = NO;
    } else if(threshold == 0.f) {
        self.mImagePreview.hidden = YES;
        self.mCurrentPreview.hidden = NO;
        self.direction = nil;
        self.mCurrentPreview.userInteractionEnabled = YES;
    }
    
    if (self.direction == [Directions LEFT]) {
        self.watchedGoodLabel.alpha = 0.f;
        self.watchedLabel.alpha = 0.f;
        self.notSureLabel.alpha = threshold;
        self.laterLabel.alpha = 0.f;
    } else if (self.direction == [Directions DOWN]) {
        self.watchedGoodLabel.alpha = 0.f;
        self.watchedLabel.alpha = 0.f;
        self.notSureLabel.alpha = 0.f;
        self.laterLabel.alpha = threshold;
    } else if (self.direction == [Directions RIGHT]) {
        self.watchedGoodLabel.alpha = threshold;
        self.watchedLabel.alpha = 0.f;
        self.notSureLabel.alpha = 0.f;
        self.laterLabel.alpha = 0.f;
    } else if (self.direction == [Directions UP]) {
        self.watchedGoodLabel.alpha = 0.f;
        self.watchedLabel.alpha = threshold;
        self.notSureLabel.alpha = 0.f;
        self.laterLabel.alpha = 0.f;
    } else if (threshold == 0.f) {
        self.watchedGoodLabel.alpha = 0.f;
        self.watchedLabel.alpha = 0.f;
        self.notSureLabel.alpha = 0.f;
        self.laterLabel.alpha = 0.f;
    }

}

- (void)onDirectionSwipe:(UISwipesViewCell*)card direction:(Directions*)direction {
    self.direction = direction;
}

- (void)onSuccessfulSwipe:(UISwipesViewCell*)card direction:(Directions*)direction {
    
    if(![card isEqual:self.superview.superview]) return;
    self.mCurrentPreview.trailerId = @"";
}
@end
