//
//  ReelContentGroup.m
//  SwipesObjCExamples
//
//  Created by Christopher Miller on 7/21/15.
//  Copyright (c) 2016 Operators. All rights reserved.
//

#import "ReelContentGroup.h"
#import "UIWebView+Id.h"

@implementation ReelContentGroup

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
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    if(DEBUG) self.backgroundColor = [UIColor clearColor];
    else  self.backgroundColor = [UIColor clearColor];
    
    
    self.mImdbView = [[UIButton alloc]initWithFrame:CGRectZero];
    [self.mImdbView setImage:[UIImage imageNamed:@"imdb"] forState:UIControlStateNormal];
    [self.mImdbView addTarget:self action:@selector(openImdb) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.mImdbView];
    [self.mImdbView setTranslatesAutoresizingMaskIntoConstraints:NO];

    self.mDescription = [[UITextView alloc]initWithFrame:CGRectZero];
    [self addSubview:self.mDescription];
    [self.mDescription setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    self.mDescription.textContainer.maximumNumberOfLines = 2;
    self.mDescription.textContainer.lineBreakMode = NSLineBreakByTruncatingTail;
    
    self.mDescription.font = [UIFont systemFontOfSize:15];
    self.mDescription.contentInset = UIEdgeInsetsMake(0.0, 10.0, 0.0, 5.0);
    
    self.mDescription.textColor = [UIColor whiteColor];
    self.mDescription.backgroundColor = [UIColor clearColor];
    self.mDescription.selectable = NO;
    self.mDescription.scrollEnabled = NO;
    
    
    CGFloat height = ([UIScreen mainScreen].bounds.size.height / 7) * 2 - 27;
    CGFloat width = ([UIScreen mainScreen].bounds.size.width / 5) * 1;
    
    [self addConstraints:[self.mDescription constrainToLeftOfSuperView:10]];
    [self addConstraints:[self.mDescription constrainToTopOfSuperView:10]];
    [self addConstraints:[self.mDescription constrainHeight:height]];
    [self addConstraints:[self.mDescription constrainWidth:width  * 3.2]];
    
    [self addConstraints:[self.mImdbView anchorToRight:self.mDescription padding:10]];
    [self addConstraints:[self.mImdbView constrainToTopOfSuperView:10]];
    [self addConstraints:[self.mImdbView constrainHeight:height - 65]];
    [self addConstraints:[self.mImdbView constrainWidth:width - 20]];
    
}

-(void) setReelDescription:(NSString*)desc {
    self.mDescription.text = desc;
}

-(void)openImdb {
    
    UIApplication *ourApplication = [UIApplication sharedApplication];
    NSString *imdbScheme = [NSString stringWithFormat:[self getImdbUri], self.mReelId];
    NSURL *imdbURL = [NSURL URLWithString:imdbScheme];
    
    if (![ourApplication canOpenURL:imdbURL]) {
        imdbScheme = [NSString stringWithFormat:[self getImdbUrl], self.mReelId];
        imdbURL = [NSURL URLWithString:imdbScheme];
    }
    
    [ourApplication openURL:imdbURL];
}
-(NSString*) getImdbUri {
    return @"imdb:///title/%@/";
}
-(NSString*) getImdbUrl {
    return @"http://m.imdb.com/title/%@/";
}
@end
