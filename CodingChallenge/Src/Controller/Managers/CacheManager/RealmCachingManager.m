//
//  RealmCachingManager.m
//  CodingChallenge
//
//  Created by Peter Mosaad on 11/17/15.
//  Copyright (c) 2015 Inventorum. All rights reserved.
//

#import "RealmCachingManager.h"
#import "ProductRealm.h"
#import <Realm/Realm.h>

@implementation RealmCachingManager

+(RealmCachingManager *)sharedInstance
{
    static RealmCachingManager* sharedInstance;
    
    @synchronized(self) {
        if (sharedInstance == nil) {
            sharedInstance = [[self alloc] init];
        }
    }
    return sharedInstance;
}

- (void)deleteOldItems
{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm deleteAllObjects];
    [realm commitWriteTransaction];
}

- (NSArray*)getSavedProductsList
{
    RLMResults *realmResults = [ProductRealm allObjectsInRealm:[RLMRealm defaultRealm]];
    
    NSMutableArray* savedProductsList = [NSMutableArray array];
    for(int i = 0; i < realmResults.count; i++)
        [savedProductsList addObject:[(ProductRealm*)[realmResults objectAtIndex:i] product]];
    
    return savedProductsList;
}

- (void)saveProductsList:(NSArray *)products clearOld:(BOOL)clearOlad
{
   /// Delete cached list
    if(clearOlad)
        [self deleteOldItems];
   
    ///
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    
    for(Product *aProduct in products)
    {
        ProductRealm* productToBeSaved = [ProductRealm realmProductFromProduct:aProduct];
        [realm addObject:productToBeSaved];
    }
    [realm commitWriteTransaction];
}

@end
