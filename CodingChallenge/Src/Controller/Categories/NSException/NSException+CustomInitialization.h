//
//  NSException+CustomInitialization.h
//  CodingChallenge
//
//  Created by Peter on 10/31/13.
//  Copyright (c) 2014 . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSException (CustomInitialization)

+ (NSException *)exceptionWithError:(NSError*)error;
- (NSError*)error;
@end
