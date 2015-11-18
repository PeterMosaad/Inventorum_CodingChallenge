//
//  Product+JSON.m
//  CodingChallenge
//
//  Created by Peter Mosaad on 11/17/15.
//  Copyright (c) 2015 Inventorum. All rights reserved.
//

#import "Product+JSON.h"

@implementation Product (JSON)

- (id)initWithJSONObject:(NSDictionary*)json
{
    self = [super init];
    if(self)
    {
        [self getDataFromJsonObject:json];
    }
    
    return self;
}

- (void)getDataFromJsonObject:(NSDictionary*)json
{
    id val;
    
    val = [json objectForKey:@"id"];
    if(val && [val isKindOfClass:[NSNumber class]])
        self.product_id = val;
    
    val = [json objectForKey:@"name"];
    if(val && [val isKindOfClass:[NSString class]])
        self.name = val;

    val = [json objectForKey:@"quantity"];
    if(val && [val isKindOfClass:[NSString class]])
        self.quantity = val;

    val = [json objectForKey:@"reorder_level"];
    if(val && [val isKindOfClass:[NSString class]])
        self.reorder_level = val;

    val = [json objectForKey:@"safety_stock"];
    if(val && [val isKindOfClass:[NSString class]])
        self.safety_stock = val;

    val = [json objectForKey:@"gross_price"];
    if(val && [val isKindOfClass:[NSString class]])
        self.gross_price = val;    
}

@end
