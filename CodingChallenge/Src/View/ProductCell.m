//
//  ProductCell.m
//  CodingChallenge
//
//  Created by Peter Mosaad on 11/17/15.
//  Copyright (c) 2015 Inventorum. All rights reserved.
//

#import "ProductCell.h"

@implementation ProductCell

- (NSAttributedString*)attributedStringForTitle:(NSString*)title value:(NSString*)value
{
    UIColor* titleColor = [UIColor colorWithRed:18.0f/255.0f green:45.0f/255.0f blue:83.0f/255.0f alpha:1.0];
    UIColor* valueColor = [UIColor colorWithRed:106.0f/255.0f green:106.0f/255.0f blue:106.0f/255.0f alpha:1.0];
    UIFont* titleFont = [UIFont fontWithName:@"HelveticaNeue" size:13.5];
    UIFont* valueFont = [UIFont fontWithName:@"HelveticaNeue" size:13.5];
    NSMutableAttributedString* titleStr = [[NSMutableAttributedString alloc] initWithString:title
                                                                                 attributes:@{NSFontAttributeName : titleFont, NSForegroundColorAttributeName : titleColor}];
    
    NSAttributedString* valueStr = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@": %@", value]
                                                                   attributes:@{NSFontAttributeName : valueFont, NSForegroundColorAttributeName : valueColor}];
    [titleStr appendAttributedString:valueStr];
    
    return titleStr;
}


- (void)updateCellWithProduct:(Product*)product
{
    currentProdcut = product;
    
    nameLabel.text = currentProdcut.name;
    nameLabel.layer.cornerRadius = 8.0;
    nameLabel.clipsToBounds = YES;
    
    quantityLabel.attributedText = [self attributedStringForTitle:NSLocalizedString(@"Quantity", ) value:currentProdcut.quantity];
    reorderLevelLabel.attributedText = [self attributedStringForTitle:NSLocalizedString(@"Reorder level", ) value:currentProdcut.reorder_level];
    safetyStockLabel.attributedText = [self attributedStringForTitle:NSLocalizedString(@"Safety stock", ) value:currentProdcut.safety_stock];
    grossOriceLabel.attributedText = [self attributedStringForTitle:NSLocalizedString(@"Gross price", ) value:currentProdcut.gross_price];
    
    containerView.layer.borderWidth = 2;
    containerView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    containerView.layer.cornerRadius = 8.0;
}

@end
