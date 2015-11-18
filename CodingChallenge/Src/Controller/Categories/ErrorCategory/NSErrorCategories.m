//
//  NSErrorCategories.m
//  CodingChallenge
//
//  Created by Peter Mosaad on 6/12/12.
//  Copyright (c) 2012 Company. All rights reserved.
//

#import "NSErrorCategories.h"

@implementation NSError (Addition)

- (void)showWithDelegate:(NSObject<UIAlertViewDelegate>*)delegate andTitle:(NSString *)title
{
    if((![self.domain isEqualToString:NonDisplayedErrorsDomain]) && self.code != NonDisplayedErrorsCode)
    {
        if (!title)
            title = @"";
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:[self localizedDescription]
                                                       delegate:delegate
                                              cancelButtonTitle:nil
                                              otherButtonTitles:[NSLocalizedString(@"ok", @"") uppercaseString], nil];
        [alert show];
    }
}

- (void)show {
    if ([self localizedDescription] && [self localizedDescription].length > 0) {
        [self showWithDelegate:nil andTitle:@""];
    }
}

- (void)showWithTitle:(NSString *)title {
    if ([self localizedDescription] && [self localizedDescription].length > 0) {
        [self showWithDelegate:nil andTitle:title];
    }
}

@end