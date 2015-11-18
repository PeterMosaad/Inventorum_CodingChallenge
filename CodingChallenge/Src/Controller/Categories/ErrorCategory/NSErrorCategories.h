//
//  NSErrorCategories.h
//  CodingChallenge
//
//  Created by Peter on 10/30/13.
//  Copyright (c) 2014 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define NonDisplayedErrorsDomain @"NonDisplayedErrorsDomain"
#define NonDisplayedErrorsCode 1397

@interface NSError (Addition)

// A category for NSError that uses a UIAlertView to directly present the error message.

- (void)showWithDelegate:(NSObject<UIAlertViewDelegate>*)delegate andTitle:(NSString *)title;
- (void)show;
- (void)showWithTitle:(NSString *)title;

@end
