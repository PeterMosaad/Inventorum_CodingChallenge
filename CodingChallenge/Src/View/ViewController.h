//
//  ViewController.h
//  CodingChallenge
//
//  Created by Peter Mosaad on 11/17/15.
//  Copyright (c) 2015 Inventorum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetProductsOperation.h"

@interface ViewController : UIViewController <BaseOperationDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>
{
    __weak IBOutlet UICollectionView *productsCollectionView;
    NSMutableArray* productsList;
}

@end

