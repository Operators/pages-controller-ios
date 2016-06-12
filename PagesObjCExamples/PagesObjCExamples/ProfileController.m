//
//  ProfileController.m
//  PagesObjCExamples
//
//  Created by Christopher Miller on 12/04/16.
//  Copyright © 2016 Operators. All rights reserved.
//

#import "WalkthroughController.h"
#import "ProfileController.h"
#import <UISwipes/UISwipes.h>
#import "YouTubePresenter.h"
#import "ReelContentGroup.h"

@interface ProfileCell : UISwipesViewCell
@property (strong, nonatomic) IBOutlet YouTubePresenter *youTubePresenter;
@property (strong, nonatomic) IBOutlet ReelContentGroup *reelContentGroup;
@end

@implementation ProfileCell
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

@interface ProfileController () <UISwipesViewDataSource, UISwipesViewDelegate>
@property (strong, nonatomic) NSMutableArray *reelsData;

@property (strong, nonatomic) NSArray *reelsGuide;
@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) NSInteger iteration;

@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UISwipesView *swipesView;
@end

@implementation ProfileController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString* filePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"html"];
    NSString *htmlFile = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    NSString *popcorn = [htmlFile stringByReplacingOccurrencesOfString:@"%s" withString:@"popcorn.gif"];
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    [self.webView loadHTMLString:popcorn baseURL:baseURL];
    
    self.reelsGuide = @[
                        @"We need to get your profile started...",
                        @"The first few Reels you see here will get you up and running.",
                        @"If you have seen Back to the Future and liked it, you know what to do...",
                        @"Do you want to see Lord of the Rings?",
                        @"Do you want to see The Dark Knight?",
                        @"Great! Our servers are churning more butter for your popcorn...",
                        ];
    
    self.reelsData = [@[
                        @{
                            @"id" : @"tt0088763",
                            @"desc" : @"A young man is accidentally sent thirty years into the past in a time-traveling DeLorean invented by his friend, Dr. Emmett Brown, and must make sure his high-school-age parents unite in order to save his own existence.",
                            @"trailer" : @"qvsgGtivCgs",
                            },
                        @{
                            @"id" : @"tt0167260",
                            @"desc" : @"Gandalf and Aragorn lead the World of Men against Sauron's army to draw his gaze from Frodo and Sam as they approach Mount Doom with the One Ring.",
                            @"trailer" : @"r5X-hFf6Bwo",
                            },
                        @{
                            @"id" : @"tt0468569",
                            @"desc" : @"When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, the caped crusader must come to terms with one of the greatest psychological tests of his ability to fight injustice.",
                            @"trailer" : @"EXeTwQWrcwY",
                            }
                        ] mutableCopy];

    
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
    ProfileCell *cell = (ProfileCell*)[swipesView dequeueReusableCellWithReuseIdentifier:@"ProfileCell"forIndexPath:indexPath];
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
        
        if(index == 2) {
            [self.swipesView setAllowedDirections:@[ [Directions LEFT], [Directions DOWN], [Directions RIGHT], [Directions UP] ]];
            
            self.headerLabel.text = self.reelsGuide[index];
            self.headerLabel.alpha = 1.0;
        } else if(index == 3) {
            
            self.headerLabel.text = self.reelsGuide[index];
            self.headerLabel.alpha = 1.0;
        } else if(index == 4) {
            
            self.headerLabel.text = self.reelsGuide[index];
            self.headerLabel.alpha = 1.0;
        } else if(index == 5) {
            
            self.headerLabel.text = self.reelsGuide[index];
            self.headerLabel.alpha = 1.0;
            
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
    
    int index = -1;
    
    if(self.reelsData.count == 2) index = 3;
    else if(self.reelsData.count == 1) index = 4;
    else if(self.reelsData.count == 0) index = 5;
    
    NSLog(@"index=%d", index);
    self.headerLabel.text = self.reelsGuide[index];
    
    if(self.reelsData.count != 0) {
        // SAVE TO PROFILE

        [self startPresentation];
    } else {
        
        // EXIT WALKTHROUGH
        [self.timer invalidate];
        NSLog(@"Walk through complete!");
        self.webView.hidden = NO;
        [NSThread sleepForTimeInterval:2.5];
        
        WalkthroughController *parent = (WalkthroughController*) self.parentViewController;
        [parent dismissViewControllerAnimated:YES completion:nil];
    }
}


@end
