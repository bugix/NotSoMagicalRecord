//
//  MagicalRecord.h
//
//  Created by Saul Mora on 3/11/10.
//  Copyright 2010 Magical Panda Software, LLC All rights reserved.
//

#import <Foundation/Foundation.h>
#import <NotSoMagicalRecord/NotSoMagicalRecordXcode7CompatibilityMacros.h>

// enable to use caches for the fetchedResultsControllers (iOS only)
// #define STORE_USE_CACHE

#ifdef NS_BLOCKS_AVAILABLE

@class NSManagedObjectContext;
typedef void (^CoreDataBlock)(NSManagedObjectContext * __MR_nonnull context);

#endif

/**
 Provides class methods to help setup, save, handle errors and provide information about the currently loaded version of MagicalRecord.

 @since Available in v1.0 and later.
 */
@interface NotSoMagicalRecord : NSObject

@end
