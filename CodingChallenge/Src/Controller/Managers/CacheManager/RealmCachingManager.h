//
//  RealmCachingManager.h
//  CodingChallenge
//
//  Created by Peter Mosaad on 11/17/15.
//  Copyright (c) 2015 Inventorum. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RealmCachingManager : NSObject

+ (RealmCachingManager *)sharedInstance;

- (NSArray*)getSavedProductsList;
- (void)saveProductsList:(NSArray *)products clearOld:(BOOL)clearOlad;
- (void)deleteOldItems;

@end
