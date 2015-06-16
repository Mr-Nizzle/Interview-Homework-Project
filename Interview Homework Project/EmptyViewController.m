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

@end
