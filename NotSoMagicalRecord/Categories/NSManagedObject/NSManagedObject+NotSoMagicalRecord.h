//
//
//  Created by Saul Mora on 11/15/09.
//  Copyright 2010 Magical Panda Software, LLC All rights reserved.
//

#import <CoreData/CoreData.h>
#import <NotSoMagicalRecord/NotSoMagicalRecordXcode7CompatibilityMacros.h>

@interface NSManagedObject (NotSoMagicalRecord)

+ (MR_nonnull NSString *) MR_entityName;

+ (NSUInteger) MR_defaultBatchSize;
+ (void) MR_setDefaultBatchSize:(NSUInteger)newBatchSize;

+ (MR_nullable MR_NSArrayOfNSManagedObjects) MR_executeFetchRequest:(MR_nonnull NSFetchRequest *)request inContext:(MR_nonnull NSManagedObjectContext *)context;
+ (MR_nullable instancetype) MR_executeFetchRequestAndReturnFirstObject:(MR_nonnull NSFetchRequest *)request inContext:(MR_nonnull NSManagedObjectContext *)context;

+ (BOOL) MR_performFetch:(MR_nonnull NSFetchedResultsController *)controller;

+ (MR_nullable NSEntityDescription *) MR_entityDescriptionInContext:(MR_nonnull NSManagedObjectContext *)context;
+ (MR_nullable MR_GENERIC(NSArray, NSPropertyDescription *) *) MR_propertiesNamed:(MR_nonnull MR_GENERIC(NSArray, NSString *) *)properties inContext:(MR_nonnull NSManagedObjectContext *)context;

+ (MR_nullable instancetype) MR_createEntityInContext:(MR_nonnull NSManagedObjectContext *)context;

- (BOOL) MR_deleteEntityInContext:(MR_nonnull NSManagedObjectContext *)context;

+ (BOOL) MR_deleteAllMatchingPredicate:(MR_nonnull NSPredicate *)predicate inContext:(MR_nonnull NSManagedObjectContext *)context;

+ (BOOL) MR_truncateAllInContext:(MR_nonnull NSManagedObjectContext *)context;

+ (MR_nonnull MR_GENERIC(NSArray, NSSortDescriptor *) *) MR_ascendingSortDescriptors:(MR_nonnull MR_GENERIC(NSArray, NSString *) *)attributesToSortBy;
+ (MR_nonnull MR_GENERIC(NSArray, NSSortDescriptor *) *) MR_descendingSortDescriptors:(MR_nonnull MR_GENERIC(NSArray, NSString *) *)attributesToSortBy;

@end


