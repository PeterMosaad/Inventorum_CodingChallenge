//
//  UIView+Loading.h
//  CodingChallenge
//
//  Created by Peter Mosaad on 6/25/13.
//  Copyright (c) 2014  All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

#define BaseIndicatorSize 30.0

@interface UIView (Loading)

- (MBProgressHUD*)showProgressWithMessage:(NSString*)message;
- (void)hideProgress;

@end
