//
//  Product.h
//  CodingChallenge
//
//  Created by Peter Mosaad on 11/17/15.
//  Copyright (c) 2015 Inventorum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface Product : NSObject

@property (strong) NSNumber* product_id;
@property (strong) NSString* name;
@property (strong) NSString* quantity;
@property (strong) NSString* reorder_level;
@property (strong) NSString* safety_stock;
@property (strong) NSString* gross_price;


@end
