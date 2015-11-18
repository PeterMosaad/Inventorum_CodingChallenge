//
//  ViewController.m
//  CodingChallenge
//
//  Created by Peter Mosaad on 11/17/15.
//  Copyright (c) 2015 Inventorum. All rights reserved.
//

#import "ViewController.h"
#import "GetProductsOperation.h"
#import "NSErrorCategories.h"
#import "UIView+Loading.h"
#import "ProductCell.h"
#import <CCBottomRefreshControl/UIScrollView+BottomRefreshControl.h>

@interface ViewController ()
{
    int currentPageIndex;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self addRefreshControl];
    
    [self getProductsList];
}

- (void)addRefreshControl
{
    UIRefreshControl *bottomRefreshControl = [UIRefreshControl new];
    [bottomRefreshControl addTarget:self action:@selector(getNextPage:) forControlEvents:UIControlEventValueChanged];
    productsCollectionView.bottomRefreshControl = bottomRefreshControl;
}

- (void)getNextPage:(UIRefreshControl*)sender
{
    [sender endRefreshing];
    currentPageIndex ++;
    [self getProductsList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Request Data

- (void)getProductsList
{
    if(!currentPageIndex)
        currentPageIndex = 1;
    
    [self.view showProgressWithMessage:NSLocalizedString(@"Loading",)];
    [GetProductsOperation addObserver:self];
    [BaseOperation queueInOperation:[[GetProductsOperation alloc] initToGetListWithPageIndex:currentPageIndex]];
}

#pragma mark - UICollectionviewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return productsList.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat size = collectionView.frame.size.width/2.0 - 10;/// For padding, Make two cells per row
    return CGSizeMake(size, size);
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ProductCell_ID";
    ProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    [(ProductCell*) cell updateCellWithProduct:[productsList objectAtIndex:indexPath.row]];
    return cell;
}

#pragma mark - BaseOperationDelegate
- (void)operation:(GetProductsOperation*)operation succededWithObject:(id)object
{
    [self.view hideProgress];
    [[operation class] removeObserver:self];
    
    if(operation.pageIndex > 1)
        [productsList addObjectsFromArray:object];
    else
        productsList = [NSMutableArray arrayWithArray:object];
    
    [productsCollectionView reloadData];
}

- (void)operation:(BaseOperation*)operation failedWithError:(NSError*)error userInfo:(id)info
{
    [self.view hideProgress];
    [error show];
    [[operation class] removeObserver:self];
}

@end
