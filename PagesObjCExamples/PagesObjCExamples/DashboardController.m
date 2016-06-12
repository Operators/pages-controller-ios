//
//  DashboardController.m
//  PagesObjCExamples
//
//  Created by Christopher Miller on 12/04/16.
//  Copyright © 2016 Operators. All rights reserved.
//

#import "DashboardController.h"

@interface DashboardController ()

@end

@implementation DashboardController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"reel_bg"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
}
@end
