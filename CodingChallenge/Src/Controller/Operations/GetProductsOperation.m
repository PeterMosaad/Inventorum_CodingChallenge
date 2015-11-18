//
//  GetProductsOperation.m
//  CodingChallenge
//
//  Created by Peter Mosaad on 11/17/15.
//  Copyright (c) 2015 Inventorum. All rights reserved.
//

#import "GetProductsOperation.h"
#import "Product+JSON.h"
#import "RealmCachingManager.h"
#import "Constants.h"

// String used to identify the update object in the user defaults storage.
static NSString * const kLastStoreUpdateKey = @"LastStoreUpdate";

#define ProductsList_PageMaxSize 20


@implementation GetProductsOperation


- (id)initToGetListWithPageIndex:(int)pIndex
{
    self = [super init];
    self.pageIndex = pIndex;
    return self;
}

- (id)doMain
{
    /// Try to get list if failed get from Cached list
    /// TODO: Fix the issue that only last list is loaded regardles request parameters (sort type .. etc
    @try
    {
        NSData* httpResponse = [self doRequest];
        
        ///
        [self parseHttpResponse:httpResponse];
        
        /// Cache new List and clear only if it's the first page
        [[RealmCachingManager sharedInstance] saveProductsList:productsList clearOld:self.pageIndex
          == 1];
    }
    @catch (NSException *exception) {
        /// If failed to get the prodcuts list read last cached list only if its the initial request list
        if(self.pageIndex == 1)
            productsList = [NSMutableArray arrayWithArray:[[RealmCachingManager sharedInstance] getSavedProductsList]];
    }
    @finally {
        return productsList;
    }

    return productsList;
}

- (NSData *)doRequest
{
    /// construct URL and Create connection
    NSString* url = [NSString stringWithFormat:@"%@%@?limit=%d&page=%d", BaseServiceURL, GetProducts_URLSuffix, ProductsList_PageMaxSize, self.pageIndex];
    
    NSDictionary* headers = [BaseOperation httpHeaders];
    
    return [BaseOperation doRequestWithHttpMethod:@"GET" URL:url requestBody:nil customHttpHeaders:headers forOperation:self];
}

- (void)parseHttpResponse:(NSData*)response
{
    NSError* error;
    NSDictionary* responseJson = [NSJSONSerialization JSONObjectWithData:response options:kNilOptions error:&error];
    if(error)
        [BaseOperation throughExceptionWithError:error];
    else
    {
        if([responseJson isKindOfClass:[NSDictionary class]])
        {
            NSArray* resultsJson = [responseJson valueForKey:@"data"];
            if([resultsJson isKindOfClass:[NSArray class]])
            {
                productsList = [NSMutableArray array];
                for(NSDictionary* productJson in resultsJson)
                    [productsList addObject:[[Product alloc] initWithJSONObject:productJson]];

            }
            else
            {
                // TODO: Ask for error message within response
                error = [NSError errorWithDomain:@"OperationFailed" code:123 userInfo:[NSDictionary dictionaryWithObject:NSLocalizedString(@"Failed to Get Products List",) forKey:NSLocalizedDescriptionKey]];
                [self.class throughExceptionWithError:error];
            }
        }
    }
}

@end
