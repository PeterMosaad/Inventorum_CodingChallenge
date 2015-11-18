//
//  Product+JSON.h
//  CodingChallenge
//
//  Created by Peter Mosaad on 11/17/15.
//  Copyright (c) 2015 Inventorum. All rights reserved.
//

#import "Product.h"

@interface Product (JSON)

- (id)initWithJSONObject:(NSDictionary*)json;

@end
