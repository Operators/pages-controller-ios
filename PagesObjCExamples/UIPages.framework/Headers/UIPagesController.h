//
//  UIPagesController.h
//  UIPages
//
//  Created by Christopher Miller on 11/04/16.
//  Copyright © 2016 Operators. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol UIPagesDataSource
-(NSArray*)getIdentifiers;
-(NSString*)getStoryboardName;
@end
@interface UIPagesController : UIPageViewController<UIPageViewControllerDataSource, UIPageViewControllerDelegate>
@property (strong, nonatomic) NSArray *identifiers;
@property (strong, nonatomic) id<UIPagesDataSource> pagesSource;
-(void)moveToPosition:(NSInteger)position;
@end
