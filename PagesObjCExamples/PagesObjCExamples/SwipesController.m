//
//  SwipesController.m
//  PagesObjCExamples
//
//  Created by Christopher Miller on 12/04/16.
//  Copyright © 2016 Operators. All rights reserved.
//

#import "WalkthroughController.h"
#import "SwipesController.h"
#import <UISwipes/UISwipes.h>
#import "UIWebView+Id.h"
#import "YouTubePresenter.h"
#import "ReelContentGroup.h"

@interface SwipesCell : UISwipesViewCell
@property (strong, nonatomic) IBOutlet YouTubePresenter *youTubePresenter;
@property (strong, nonatomic) IBOutlet ReelContentGroup *reelContentGroup;
@end

@implementation SwipesCell
- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        
        UIGraphicsBeginImageContext(self.frame.size);
        [[UIImage imageNamed:@"reel_bg"] drawInRect:self.bounds];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        self.backgroundColor = [UIColor colorWithPatternImage:image];
        self.layer.speed = 0.5; //default speed is 1
    }
    return self;
}
@end
@interface SwipesController () <UISwipesViewDataSource, UISwipesViewDelegate>
@property (strong, nonatomic) NSMutableDictionary *reelData;
@property (strong, nonatomic) NSMutableArray *reelsData;

@property (strong, nonatomic) NSArray *reelsGuide;
@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) NSInteger iteration;

@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UISwipesView *swipesView;
@end

@implementation SwipesController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.reelsGuide = @[
                        @"Now let's get started...",
                        @"This is a Reel and it can be swiped in all 4 major directions.",
                        @"Suggestions can be right swiped to save as WATCHED Good",
                        @"Try right swiping now...",
                        @"You just right swiped, and we can now move on to swiping away.",
                        @"You can swipe away (or up swipe) to simply save as WATCHED",
                        @"Try swiping away now..."
                        ];
    
    self.reelData = [@{
                      @"id" : @"tt0110912",
                      @"desc" : @"The lives of two mob hit men, a boxer, a gangster's wife, and a pair of diner bandits intertwine in four tales of violence and redemption.",
                      @"trailer" : @"s7EdQ4FqbhY",
                      } mutableCopy];
    
    self.reelsData = [@[ self.reelData ] mutableCopy];
    
    [self.swipesView setDataSource:self];
    [UISwipesView addUISwipesViewDelegate:self];
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.iteration = 0;
    self.headerLabel.text = self.reelsGuide[self.iteration];
    [self startPresentation];
}
-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    self.iteration = 0;
    [UISwipesView removeUISwipesViewDelegate:self];
}

- (CGPoint)swipesView:(UISwipesView *)swipesView centerForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize screenBounds = [[UIScreen mainScreen] bounds].size;
    return CGPointMake(screenBounds.width * .50f, screenBounds.height * .50f);
}
- (CGSize)swipesView:(UISwipesView *)swipesView sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(280, 300);
}
- (NSInteger)swipesView:(UISwipesView *)swipesView numberOfItemsInSection:(NSInteger) nis {
    return self.reelsData.count;
}
- (UISwipesViewCell *)swipesView:(UISwipesView *)swipesView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SwipesCell *cell = (SwipesCell*)[swipesView dequeueReusableCellWithReuseIdentifier:@"SwipesCell"forIndexPath:indexPath];
    NSDictionary * reel = self.reelsData[indexPath.item];
    
    ReelContentGroup *rcg = (ReelContentGroup*) cell.reelContentGroup;
    YouTubePresenter *ytp = (YouTubePresenter*) cell.youTubePresenter;
    
    rcg.mReelId = reel[@"id"];
    [rcg setReelDescription:reel[@"desc"]];
    [ytp setUpTrailer:reel[@"trailer"]];
    [UISwipesView addUISwipesViewDelegate:ytp];
    
    return cell;
}
- (void)swipesView:(UISwipesView *)swipesView postSwipeOperationAtIndexPath:(NSIndexPath*)indexPath {
    [self.reelsData removeObjectAtIndex:indexPath.item];
}

-(void)startPresentation {
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self
                                                selector:@selector(updatePresentation)
                                                userInfo:nil repeats:YES];
}
-(void)updatePresentation {
    float divisor = 5.0;
    int offset = ++self.iteration % (int)divisor;
    
    if(offset == 0) {
        [self.timer invalidate];
        
        int index = self.iteration / (int)divisor;
        NSLog(@"index=%d", index);
        
        if(index == self.reelsGuide.count) return;
        
        if(index == 3) {
            [self.swipesView setAllowedDirections:@[ [Directions RIGHT] ]];
            self.headerLabel.text = self.reelsGuide[index];
            self.headerLabel.alpha = 1;
        } else if(index == 6) {
            [self.swipesView setAllowedDirections:@[ [Directions UP] ]];
            self.headerLabel.text = self.reelsGuide[index];
            self.headerLabel.alpha = 1;
        } else {
            self.headerLabel.text = self.reelsGuide[index];
            self.headerLabel.alpha = 1.0;
            [UIView animateWithDuration:2.5 delay:1.5 options:UIViewAnimationOptionAutoreverse animations:^{
                self.headerLabel.alpha = 0;
            } completion:nil];
            [self startPresentation];
        }
    }
}

- (void)onThresholdChange:(UISwipesViewCell*)card threshold:(CGFloat)threshold {}
- (void)onDirectionSwipe:(UISwipesViewCell*)card direction:(Directions*)direction {}
- (void)onSuccessfulSwipe:(UISwipesViewCell*)card direction:(Directions*)direction {
    
    if(direction == [Directions RIGHT]) {
        self.reelsData = [@[ self.reelData ] mutableCopy];
        self.headerLabel.text = self.reelsGuide[4];
        
        [self.swipesView reloadData];
        [self startPresentation];
    } else {
        WalkthroughController *parent = (WalkthroughController*) self.parentViewController;
        [parent moveToPosition:4];
    }
}


@end
