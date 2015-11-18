//
//  UIView+Loading.m
//  CodingChallenge
//
//  Created by Peter Mosaad on 6/25/13.
//  Copyright (c) 2014  All rights reserved.
//

#import "UIView+Loading.h"

@implementation UIView (Loading)

- (MBProgressHUD*)showProgressWithMessage:(NSString*)message
{
    MBProgressHUD* progress = [MBProgressHUD HUDForView:self];
    
    if(!progress)
    {
        progress = [MBProgressHUD showHUDAddedTo:self animated:YES];
        progress.labelText = message;
    }
    return progress;
}

- (void)hideProgress
{
    if ([NSThread isMainThread]) {
        [MBProgressHUD hideHUDForView:self animated:NO];
    }
    else {
        [self performSelectorOnMainThread:@selector(hideProgress) withObject:nil waitUntilDone:NO];
    }
}

@end