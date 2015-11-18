//
//  ProductCell.h
//  CodingChallenge
//
//  Created by Peter Mosaad on 11/17/15.
//  Copyright (c) 2015 Inventorum. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Product.h"

@interface ProductCell : UICollectionViewCell
{
    Product* currentProdcut;
    __weak IBOutlet UIView* containerView;

    __weak IBOutlet UILabel *nameLabel;
    __weak IBOutlet UILabel *quantityLabel;
    __weak IBOutlet UILabel *reorderLevelLabel;
    __weak IBOutlet UILabel *safetyStockLabel;
    __weak IBOutlet UILabel *grossOriceLabel;
}

- (void)updateCellWithProduct:(Product*)product;

@end
