//
//  NSException+CustomInitialization.m
//  CodingChallenge
//
//  Created by Peter on 10/31/13.
//  Copyright (c) 2014 . All rights reserved.
//

#import "NSException+CustomInitialization.h"

@implementation NSException (CustomInitialization)

+ (NSException *)exceptionWithError:(NSError*)error
{
    NSException* ex = [NSException exceptionWithName:@"" reason:@"" userInfo:[NSDictionary dictionaryWithObject:error forKey:@"Error"]];
    return ex;
}

- (NSError*)error
{
    return [self.userInfo objectForKey:@"Error"];
}

@end
