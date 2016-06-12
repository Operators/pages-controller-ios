//
//  WalkthroughController.m
//  PagesObjCExamples
//
//  Created by Christopher Miller on 12/04/16.
//  Copyright © 2016 Operators. All rights reserved.
//

#import "WalkthroughController.h"

@interface WalkthroughController () <UIPagesDataSource>
@end

@implementation WalkthroughController
-(NSString*)getStoryboardName {
    return @"Walkthrough";
}
-(NSArray*)getIdentifiers {
    return @[@"initial",@"dashboard",@"suggestions",@"swipes",@"remaining",@"profile"];
}
@end
