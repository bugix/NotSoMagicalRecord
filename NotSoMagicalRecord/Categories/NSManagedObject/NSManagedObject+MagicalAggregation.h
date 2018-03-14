//
//  NSManagedObject+MagicalAggregation.h
//  Magical Record
//
//  Created by Saul Mora on 3/7/12.
//  Copyright (c) 2012 Magical Panda Software LLC. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <NotSoMagicalRecord/NotSoMagicalRecordXcode7CompatibilityMacros.h>

@interface NSManagedObject (MagicalAggregation)

+ (MR_nonnull NSNumber *) MR_numberOfEntitiesWithContext:(MR_nonnull NSManagedObjectContext *)context;
+ (MR_nonnull NSNumber *) MR_numberOfEntitiesWithPredicate:(MR_nullable NSPredicate *)searchTerm inContext:(MR_nonnull NSManagedObjectContext *)context;

+ (NSUInteger) MR_countOfEntitiesWithContext:(MR_nonnull NSManagedObjectContext *)context;
+ (NSUInteger) MR_countOfEntitiesWithPredicate:(MR_nullable NSPredicate *)searchFilter inContext:(MR_nonnull NSManagedObjectContext *)context;

+ (BOOL) MR_hasAtLeastOneEntityInContext:(MR_nonnull NSManagedObjectContext *)context;

@end
