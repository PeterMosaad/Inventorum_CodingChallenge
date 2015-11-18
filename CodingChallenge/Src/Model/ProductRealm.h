//
//  ProductRealm.h
//  CodingChallenge
//
//  Created by Peter Mosaad on 11/18/15.
//  Copyright (c) 2015 Inventorum. All rights reserved.
//

#import <Realm/Realm.h>
#import "Product.h"

@interface ProductRealm : RLMObject

@property (strong) NSString* product_id;
@property (strong) NSString* name;
@property (strong) NSString* quantity;
@property (strong) NSString* reorder_level;
@property (strong) NSString* safety_stock;
@property (strong) NSString* gross_price;


+ (ProductRealm*)realmProductFromProduct:(Product*)product;
- (Product*)product;

@end
