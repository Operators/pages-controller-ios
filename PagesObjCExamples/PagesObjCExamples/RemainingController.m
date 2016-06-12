//
//  RemainingController.m
//  PagesObjCExamples
//
//  Created by Christopher Miller on 12/04/16.
//  Copyright © 2016 Operators. All rights reserved.
//

#import "RemainingController.h"

@interface RemainingController ()
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation RemainingController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString* filePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"html"];
    NSString *htmlFile = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    NSString *remaining = [htmlFile stringByReplacingOccurrencesOfString:@"%s" withString:@"remaining.gif"];
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    [self.webView loadHTMLString:remaining baseURL:baseURL];
}
@end
