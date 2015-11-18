//
//  BasicOperation.m
//  CodingChallenge
//
//  Created by Peter on 7/10/14.
//  Copyright (c) 2014  All rights reserved.
//

#import "BaseOperation.h"
#import "NSException+CustomInitialization.h"
#import "AppDelegate.h"
#import <objc/runtime.h>
#import "HTTPConnection.h"

#define CancelaionErrorCode 85246

@implementation BaseOperation

+ (NSOperationQueue*)operationQueue
{
    static NSOperationQueue* operationsQueue;
    @synchronized(self) {
        if (operationsQueue == nil) {
            operationsQueue = [NSOperationQueue new];
        }
    }
    return operationsQueue;
}

+ (void)queueInOperation:(BaseOperation*)op
{
    [[self operationQueue] addOperation:op];
}

+ (NSMutableArray*)observers
{
	static NSMutableDictionary* all_observers;
    @synchronized(self) {
        if (all_observers == nil) {
            all_observers = [[NSMutableDictionary alloc] init];
        }
    }
    
    NSString* key = NSStringFromClass([self class]);
    NSMutableArray* observers = [all_observers objectForKey:key];
    if(!observers)
    {
        observers = [NSMutableArray array];
        [all_observers setObject:observers forKey:key];
    }
    return observers;
}

+ (void)notifyObserversOfOperation:(BaseOperation*)operation Withobject:(id)operationResult error:(NSError*)error
{
    NSMutableArray* copy = [NSMutableArray arrayWithArray:[[self class] observers]];
    for(id<BaseOperationDelegate>obs in copy)
    {
        if(!error && [obs respondsToSelector:@selector(operation:succededWithObject:)])
            [obs operation:operation succededWithObject:operationResult];
        else if([obs respondsToSelector:@selector(operation:failedWithError:userInfo:)])
            [obs operation:operation failedWithError:error userInfo:operationResult];
    }
}

-(void)notifyObserversOfStartedOperation:(BaseOperation*)operation
{
    NSMutableArray* copy = [NSMutableArray arrayWithArray:[[self class] observers]];
    for(id<BaseOperationDelegate>obs in copy)
    {
        if([obs respondsToSelector:@selector(operationStartedWithOperation:)])
            [obs operationStartedWithOperation:operation];
    }
}

+ (NSDictionary*)httpHeaders
{
    /// Prepare HTTP headers that will be used for all requests sent by the application,
    return @{
             @"Authorization" : @"Bearer WSspLPc6TkD61Blx9Ft35G1jYpqW6p",
             @"X-Api-Version" : @"10"
            };
}

+ (void)throughExceptionWithError:(NSError*)error
{
    NSException* myException = [NSException exceptionWithError:error];
    @throw myException;
}
    
- (id)doMain
{
    ////Throw Exception
    return nil;
}

+ (NSData*)doRequestWithHttpMethod:(NSString*)method URL:(NSString*)url requestBody:(NSData*)body customHttpHeaders:(NSDictionary*) headers forOperation:(BaseOperation*)operation
{
    /// construct URL and Create connection
	HTTPConnection* connection = [HTTPConnection connection];
    
    /// Establish URL Connection to perform request
    NSHTTPURLResponse* httpResopnse;
    NSError* error;
    NSData* response = [connection sendSynchronousRequestByUrl:url Body:body RequestMethod:method HttpHeaders:headers serverResponse:&httpResopnse ServerError:&error];
    
    //// Check response of there is HTTP Error or should try to parse response
    if (error || (![self ensuerRequestSuccesFromHttpResponse:httpResopnse resopnseData:response]))
        [BaseOperation throughExceptionWithError:error];
    
    return response;
}

- (void)notify:(NSDictionary*)params
{
    BaseOperation* operation = [params objectForKey:@"operation"];
    id operationResult = [params objectForKey:@"operationResult"];
    NSError* error = [params objectForKey:@"error"];
    [[self class] notifyObserversOfOperation:operation Withobject:operationResult error:error];
}

- (void)main
{
    NSError* error = nil;
    id operationResult = nil;
    
    [self performSelectorOnMainThread:@selector(notifyObserversOfStartedOperation:) withObject:self waitUntilDone:NO];
    
    @try
    {
        if(!self.isCancelled)
            operationResult = [self doMain];
    }
    @catch (NSException *exception)
    {
        error = [exception error];
        if(!error)
            error = [NSError errorWithDomain:@"UnHandledError" code:-1 userInfo:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:exception.name, exception, nil] forKeys:[NSArray arrayWithObjects:NSLocalizedDescriptionKey, @"Exception", nil]]];
    }
    @finally
    {
        if(!self.isCancelled)
        {
            NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObject:self forKey:@"operation"];
            if(operationResult)
                [params setObject:operationResult forKey:@"operationResult"];
            
            if(error)
                [params setObject:error forKey:@"error"];
            
            [self performSelectorOnMainThread:@selector(notify:) withObject:params waitUntilDone:NO];            
        }
    }
}

- (BOOL)isConcurrent
{
    return FALSE;
}

+ (bool)ensuerRequestSuccesFromHttpResponse:(NSHTTPURLResponse*)httpResponse resopnseData:(NSData*)responseData
{
    NSError* error = nil;
    NSDictionary* headers = [httpResponse allHeaderFields];
    if(!httpResponse && [responseData length])
        headers = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    if(error)
        [BaseOperation throughExceptionWithError:error];
    else if([json isKindOfClass:[NSDictionary class]] && [json valueForKey:@"error"])
    {
        int errorCode = [[json valueForKey:@"status"] intValue];
        NSString* domain = ([json valueForKey:@"error"])?[json valueForKey:@"error"] : @"Unknown";
        NSString* message = ([json valueForKey:@"message"])?[json valueForKey:@"message"] : @"Server Error";
        error = [NSError errorWithDomain:domain code:errorCode userInfo:[NSDictionary dictionaryWithObject:message forKey:NSLocalizedDescriptionKey]];
    }
	
    if(error)
    {
        [BaseOperation throughExceptionWithError:error];
        return false;
    }
    
    return true;
}

- (BOOL)needsAuthentication
{
    return false;
}

#pragma mark -

+ (void)addObserver:(id<BaseOperationDelegate>)observer
{
    if(![[[self class] observers] containsObject:observer])
        [[[self class] observers] addObject:observer];
}

+ (void)removeObserver:(id<BaseOperationDelegate>)observer
{
    if([[[self class] observers] containsObject:observer])
        [[[self class] observers] removeObject:observer];
}


@end