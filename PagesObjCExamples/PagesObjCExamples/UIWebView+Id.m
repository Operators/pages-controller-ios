//
//  NSDate+NSDate_Format.m
//  Reel Life
//
//  Created by Christopher Miller on 9/3/15.
//  Copyright (c) 2015 The MAC. All rights reserved.
//

#import "UIWebView+Id.h"

@implementation UIWebView (Id)
- (NSString *) trailerId
{
    return self.accessibilityIdentifier;
}
- (void) setTrailerId:(NSString *) trailer
{
    [self loadRequest:nil];
    self.accessibilityIdentifier = trailer;
    NSString *url = [NSString stringWithFormat:@"http://www.youtube.com/embed/%@", trailer];
    
    NSURL *nsUrl = [NSURL URLWithString:url];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:nsUrl];
    [self loadRequest:urlRequest];
}

@end


@implementation NSLayoutConstraint (Extension)

+(NSArray*) constraintsWithVisualFormat:(NSString*)visualFormat views:(NSDictionary*)views {
    return [NSLayoutConstraint constraintsWithVisualFormat:visualFormat options:0 metrics:@{} views:views];
}

+(NSArray*) constraintsWithVisualFormat:(NSString*)visualFormat metrics:(NSDictionary*)metrics views:(NSDictionary*)views {
    return [NSLayoutConstraint constraintsWithVisualFormat:visualFormat options:0 metrics:metrics views:views];
}

//+(NSArray*) constraintsWithVisualFormat:(NSString*)visualFormat options: (NSLayoutFormatOptions)options metrics:(NSDictionary*)metrics views:(NSDictionary*)views {
//    return [NSLayoutConstraint constraintsWithVisualFormat:visualFormat options:options metrics:metrics views:views];
//}

+(NSLayoutConstraint*) constraintWithItem:(id)view1
                     attribute:(NSLayoutAttribute)attr1
                     relatedBy:(NSLayoutRelation)relation
                        toItem:(id)view2
                     attribute:(NSLayoutAttribute)attr2
                      constant:(CGFloat)padding {
    
    return [NSLayoutConstraint constraintWithItem:view1
                                          attribute:attr1
                                          relatedBy:relation
                                             toItem:view2
                                          attribute:attr2
                                         multiplier:1.0
                                           constant:padding];
}

+(NSLayoutConstraint*) constraintWithItem:(id)view1
                     attribute:(NSLayoutAttribute)attr
                     relatedBy:(NSLayoutRelation)relation
                        toItem:(id)view2
                      constant:(CGFloat)padding {
    
    return [NSLayoutConstraint constraintWithItem:view1
                                        attribute:attr
                                        relatedBy:relation
                                           toItem:view2
                                        attribute:attr
                                       multiplier:1.0
                                         constant:padding];
}
    
@end

@implementation UIView (Extension)

-(NSArray*) constraintsVisually:(NSString*)visualFormat {
    return [NSLayoutConstraint constraintsWithVisualFormat:visualFormat options:0 metrics:@{} views:@{@"item":self}];
}

-(NSArray*) constraintsVisually:(NSString*)visualFormat withPadding:(CGFloat)padding{
    return [NSLayoutConstraint constraintsWithVisualFormat:visualFormat options:0 metrics:@{@"padding" : @(padding)} views:@{@"item":self}];
}

-(NSArray*) constraintsVisually:(NSString*)visualFormat withWidth:(CGFloat)width{
    return [NSLayoutConstraint constraintsWithVisualFormat:visualFormat options:0 metrics:@{@"width" : @(width)} views:@{@"item":self}];
}

-(NSArray*) constraintsVisually:(NSString*)visualFormat withHeight:(CGFloat)height{
    return [NSLayoutConstraint constraintsWithVisualFormat:visualFormat options:0 metrics:@{@"height" : @(height)} views:@{@"item":self}];
}

-(NSLayoutConstraint*) constraintToItem:(id)view
                              attribute:(NSLayoutAttribute)attr
                              relatedBy:(NSLayoutRelation)relation
                               constant:(CGFloat)padding {
    
    return [NSLayoutConstraint constraintWithItem:self
                                        attribute:attr
                                        relatedBy:relation
                                           toItem:view
                                        attribute:attr
                                         constant:padding];
}

-(NSLayoutConstraint*) constraintToItem:(id)view
                              attribute:(NSLayoutAttribute)attr1
                              relatedBy:(NSLayoutRelation)relation
                              attribute:(NSLayoutAttribute)attr2
                               constant:(CGFloat)padding {
    
    return [NSLayoutConstraint constraintWithItem:self
                                        attribute:attr1
                                        relatedBy:relation
                                           toItem:view
                                        attribute:attr2
                                         constant:padding];
}

// Given an item, stretches the width and height of the view to the toItem.

-(NSArray*) stretchToBoundsOfSuperView {
	NSArray * constraints = @[
                              [self constraintsVisually:@"H:|[item]|"],
                              [self constraintsVisually:@"V:|[item]|"]];
                                            
	[self.superview addConstraints:constraints];
                                                        return constraints;
}

-(NSArray*) alignTopTo:(UIView*)toItem  padding:(CGFloat) padding {
    NSLayoutConstraint* constraint = [self constraintToItem:toItem
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                  constant:padding];
    
    [self.superview addConstraint:constraint];
    
    return @[constraint];
}
                                                        
-(NSArray*) centerHorizontallyTo:(UIView*)toItem {
    return [self centerHorizontallyTo:toItem padding: 0];
}

-(NSArray*) centerHorizontallyTo:(UIView *)toItem padding:(CGFloat)padding {

    NSLayoutConstraint* constraint = [self constraintToItem:toItem
                                 attribute:NSLayoutAttributeCenterX
                                 relatedBy:NSLayoutRelationEqual
                                  constant:padding];

    [self.superview addConstraint:constraint];

    return @[constraint];
}

-(NSArray*) centerVerticallyTo:(UIView *)toItem {
    return [self centerVerticallyTo:toItem padding: 0];
}
-(NSArray*) centerVerticallyTo:(UIView *)toItem padding:(CGFloat)padding {

    NSLayoutConstraint* constraint = [self constraintToItem:toItem
                                 attribute:NSLayoutAttributeCenterY
                                 relatedBy:NSLayoutRelationEqual
                                  constant:padding];

    [self.superview addConstraint:constraint];

    return @[constraint];
}
-(NSArray*) stretchToWidthOfSuperView {
	NSArray * constraints = [self constraintsVisually:@"H:|[item]|"];
	[self.superview addConstraints:constraints];
	return constraints;
}

-(NSArray*) stretchToWidthOfSuperView:(CGFloat)padding {
	NSArray * constraints = [self constraintsVisually:@"H:|-padding-[item]-padding-|" withPadding:padding];
	[self.superview addConstraints:constraints];
	return constraints;
}

-(NSArray*) stretchToHeightOfSuperView {
	NSArray * constraints = [self constraintsVisually:@"V:|[item]|"];
	[self.superview addConstraints:constraints];
	return constraints;
}

-(NSArray*) stretchToHeightOfSuperView:(CGFloat)padding {
	NSArray * constraints = [self constraintsVisually:@"V:|-padding-[item]-padding-|" withPadding:padding];
	[self.superview addConstraints:constraints];
	return constraints;
}

-(NSArray*) constrainToTopOfSuperView:(CGFloat)padding {
	NSArray * constraints = [self constraintsVisually:@"V:|-padding-[item]" withPadding:padding];
	[self.superview addConstraints:constraints];
	return constraints;
}
-(NSArray*) constrainToLeftOfSuperView:(CGFloat)padding {
	NSArray * constraints = [self constraintsVisually:@"H:|-padding-[item]" withPadding:padding];
	[self.superview addConstraints:constraints];
	return constraints;
}

-(NSArray*) constrainToBottomOfSuperView:(CGFloat)padding {
	NSArray * constraints = [self constraintsVisually:@"V:[item]-padding-|" withPadding:padding];
	[self.superview addConstraints:constraints];
	return constraints;
}

-(NSArray*) constrainToRightOfSuperView:(CGFloat)padding {
	NSArray * constraints = [self constraintsVisually:@"H:[item]-padding-|" withPadding:padding];
	[self.superview addConstraints:constraints];
	return constraints;
}

-(NSArray*) constrainWidth:(CGFloat)width {
	NSArray * constraints = [self constraintsVisually:@"H:[item(width)]" withWidth:width];
	[self.superview addConstraints:constraints];
	return constraints;
}
-(NSArray*) constrainHeight:(CGFloat)height {
	NSArray * constraints = [self constraintsVisually:@"V:[item(height)]" withHeight:height];
	[self.superview addConstraints:constraints];
	return constraints;
}

-(NSArray*) constrainWidthTo:(UIView *)toItem {

    NSLayoutConstraint* constraint = [self constraintToItem:toItem
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                  constant:0];

    [self.superview addConstraint:constraint];

    return @[constraint];
}
-(NSArray*) constrainHeightTo:(UIView *)toItem {

    NSLayoutConstraint* constraint = [self constraintToItem:toItem
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                  constant:0];

    [self.superview addConstraint:constraint];

    return @[constraint];
}

-(NSArray*) anchorToBottom:(UIView *)toItem padding:(CGFloat)padding {

    NSLayoutConstraint* constraint = [self constraintToItem:toItem
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                 attribute:NSLayoutAttributeBottom
                                  constant:padding];

    [self.superview addConstraint:constraint];

    return @[constraint];
}
-(NSArray*) anchorToRight:(UIView *)toItem padding:(CGFloat)padding {

    NSLayoutConstraint* constraint = [self constraintToItem:toItem
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                 attribute:NSLayoutAttributeRight
                                  constant:padding];

    [self.superview addConstraint:constraint];

    return @[constraint];
}
-(NSArray*) anchorToTop:(UIView *)toItem padding:(CGFloat)padding {

    NSLayoutConstraint* constraint = [self constraintToItem:toItem
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                 attribute:NSLayoutAttributeTop
                                  constant:padding];

    [self.superview addConstraint:constraint];

    return @[constraint];
}
-(NSArray*) anchorToLeft:(UIView *)toItem padding:(CGFloat)padding {

    NSLayoutConstraint* constraint = [self constraintToItem:toItem
                                 attribute:NSLayoutAttributeRight
                                 relatedBy:NSLayoutRelationEqual
                                 attribute:NSLayoutAttributeLeft
                                  constant:padding];

    [self.superview addConstraint:constraint];

    return @[constraint];
}

@end
