//
//  UIPagesController.m
//  UIPages
//
//  Created by Christopher Miller on 11/04/16.
//  Copyright © 2016 Operators. All rights reserved.
//

#import "UIPagesController.h"

@interface UIPagesController () <UIPagesDataSource>
@property (strong, nonatomic) NSMutableArray<UIViewController*> *pages;
@property (assign, nonatomic) NSInteger presentationIndex;
@end
@implementation UIPagesController

-(void) addPages {
    NSString *storyBoardName = [self.pagesSource getStoryboardName];
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:storyBoardName bundle:nil];
    
    if(storyBoard == nil) {
        NSString *output = [NSString stringWithFormat:@"Your story board does not have the name: %@", storyBoardName];
        @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:output userInfo:nil];
        
    }
    for (NSString* pageName in self.identifiers) {
        [self addPage:pageName toStoryBoard:storyBoard];
    }
}
-(void) addPage:(NSString*)pageName toStoryBoard:(UIStoryboard*)storyBoard {
    if(self.pages == nil) self.pages = [[NSMutableArray alloc] init];
    
    UIViewController *page = [storyBoard instantiateViewControllerWithIdentifier:pageName];
    if(page == nil) {
        NSString *output = [NSString stringWithFormat:@"Your story board must have a View Controller with the Identifier: %@", pageName];
        @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:output userInfo:nil];
    }

    if (![self.pages containsObject:page]) {
        [self.pages addObject:page];
    }
}
-(UIViewController*) getPage:(NSInteger)index {
    return [self.pages objectAtIndex:index];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pagesSource = self;
    self.identifiers = [self.pagesSource getIdentifiers];
    
    if(self.identifiers.count == 0) {
        NSString *output = [NSString stringWithFormat:@"Your story board must have a View Controller with the Identifiers: %@", self.identifiers];
        @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:output userInfo:nil];
    }

    NSLog(@"Identifiers=%@", self.identifiers);
    
    [self addPages];
    
    NSLog(@"Pages=%@", self.pages);
    
    [self setViewControllers:@[ [self getPage:0] ] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    self.delegate =self;
    self.dataSource = self;
    
}


-(NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return [self.pages count];
}
-(NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return self.presentationIndex;
}
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = [self.pages indexOfObject:viewController];
    if (index == 0) return nil;
    else {
        index--;
        return [self.pages objectAtIndex:index];
    }
    
}
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = [self.pages indexOfObject:viewController];
    if (index == [self.pages count] - 1) return nil;
    else {
        index++;
        return [self.pages objectAtIndex:index];
    }
}

-(void)moveToPosition:(NSInteger)position {
    self.presentationIndex = position;
    [self setViewControllers:@[self.pages[position]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}
@end
