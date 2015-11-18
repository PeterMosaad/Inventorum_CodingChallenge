//
//  ProductRealm.m
//  CodingChallenge
//
//  Created by Peter Mosaad on 11/18/15.
//  Copyright (c) 2015 Inventorum. All rights reserved.
//

#import "ProductRealm.h"

@implementation ProductRealm

+ (ProductRealm*)realmProductFromProduct:(Product*)product
{
    ProductRealm* realmProd = [[ProductRealm alloc] init];
   
    realmProd.product_id = [product.product_id stringValue];
    realmProd.name = product.name;
    realmProd.quantity = product.quantity;
    realmProd.reorder_level = product.reorder_level;
    realmProd.safety_stock = product.safety_stock;
    realmProd.gross_price = product.gross_price;
    
    return realmProd;
}

- (Product*)product
{
    Product* product = [[Product alloc] init];
    
    product.product_id = [NSNumber numberWithDouble:self.product_id.doubleValue];
    product.name = self.name;
    product.quantity = self.quantity;
    product.reorder_level = self.reorder_level;
    product.safety_stock = self.safety_stock;
    product.gross_price = self.gross_price;
    
    return product;
}

+ (NSDictionary *)defaultPropertyValues
{
    return @{
             @"product_id":@"product_id",
             @"name":@"name",
             @"quantity":@"quantity",
             @"reorder_level":@"reorder_level",
             @"safety_stock":@"safety_stock",
             @"gross_price":@"gross_price",
             };
}


@end
