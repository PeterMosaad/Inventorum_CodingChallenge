//
//  GetProductsOperation.h
//  CodingChallenge
//
//  Created by Peter Mosaad on 11/17/15.
//  Copyright (c) 2015 Inventorum. All rights reserved.
//

#import "BaseOperation.h"

@interface GetProductsOperation : BaseOperation
{
    NSMutableArray* productsList;
}

@property int pageIndex;

- (id)initToGetListWithPageIndex:(int)pIndex;

@end
