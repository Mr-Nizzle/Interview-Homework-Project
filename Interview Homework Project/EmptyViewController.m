//
//  EmptyViewController.m
//  Interview Homework Project
//
//  Created by Ricardo Guillen on 6/15/15.
//  Copyright (c) 2015 Applaudo Studios. All rights reserved.
//

#import "EmptyViewController.h"

@interface EmptyViewController ()

@end

@implementation EmptyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Detail";
    if (IS_IPAD) {
        if ([self.splitViewController respondsToSelector:@selector(displayModeButtonItem)]){
            self.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        }
        self.navigationItem.leftItemsSupplementBackButton = true;
        
        // add a toolbar to host the master view popover (when it is required, in portrait)
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc{
    if (![self respondsToSelector:@selector(displayModeButtonItem)]) {
        [barButtonItem setTitle:@"Venues"];
        [[self navigationItem] setLeftBarButtonItem:barButtonItem];
    } else {
        // This callback function is depreciated in IOS8. We use displayModeButtonItem.
    }
}

-(void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem{
    if (![self respondsToSelector:@selector(displayModeButtonItem)]) {
        [[self navigationItem] setLeftBarButtonItem:nil];
    } else {
        // This callback function is depreciated in IOS8. We use displayModeButtonItem.
    }
    
}

@end
