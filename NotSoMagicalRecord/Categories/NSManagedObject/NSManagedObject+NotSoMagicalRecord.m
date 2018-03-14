
//  Created by Saul Mora on 11/15/09.
//  Copyright 2010 Magical Panda Software, LLC All rights reserved.
//

#import "NSManagedObject+NotSoMagicalRecord.h"
#import "NSManagedObject+MagicalRequests.h"
#import "NotSoMagicalRecord+ErrorHandling.h"
#import "NotSoMagicalRecordLogging.h"

static NSUInteger kMagicalRecordDefaultBatchSize = 20;

@implementation NSManagedObject (NotSoMagicalRecord)

+ (NSString *) MR_entityName;
{
    return [NSStringFromClass(self) componentsSeparatedByString:@"."].lastObject;
}

+ (void) MR_setDefaultBatchSize:(NSUInteger)newBatchSize
{
    @synchronized(self)
    {
        kMagicalRecordDefaultBatchSize = newBatchSize;
    }
}

+ (NSUInteger) MR_defaultBatchSize
{
    return kMagicalRecordDefaultBatchSize;
}

+ (NSArray *) MR_executeFetchRequest:(NSFetchRequest *)request inContext:(NSManagedObjectContext *)context
{
    __block NSArray *results = nil;
    [context performBlockAndWait:^{

        NSError *error = nil;
        
        results = [context executeFetchRequest:request error:&error];
        
        if (results == nil) 
        {
            [NotSoMagicalRecord handleErrors:error];
        }

    }];
    return results;    
}

+ (instancetype) MR_executeFetchRequestAndReturnFirstObject:(NSFetchRequest *)request inContext:(NSManagedObjectContext *)context
{
    request.fetchLimit = 1;
    
    NSArray *results = [self MR_executeFetchRequest:request inContext:context];
    if (results.count == 0)
    {
        return nil;
    }
    return results.firstObject;
}

+ (BOOL) MR_performFetch:(NSFetchedResultsController *)controller
{
    NSError *error = nil;
    BOOL success = [controller performFetch:&error];
    if (!success)
    {
        [NotSoMagicalRecord handleErrors:error];
    }
    return success;
}

+ (NSEntityDescription *) MR_entityDescriptionInContext:(NSManagedObjectContext *)context
{
    NSString *entityName = [self MR_entityName];
    return [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
}

+ (NSArray *) MR_propertiesNamed:(NSArray *)properties inContext:(NSManagedObjectContext *)context
{
    NSEntityDescription *description = [self MR_entityDescriptionInContext:context];
    NSMutableArray *propertiesWanted = [NSMutableArray array];

    if (properties)
    {
        NSDictionary *propDict = description.propertiesByName;

        for (NSString *propertyName in properties)
        {
            NSPropertyDescription *property = propDict[propertyName];
            if (property)
            {
                [propertiesWanted addObject:property];
            }
            else
            {
                MRLogWarn(@"Property '%@' not found in %lx properties for %@", propertyName, (unsigned long)[propDict count], NSStringFromClass(self));
            }
        }
    }
    return propertiesWanted;
}

+ (NSArray *) MR_sortAscending:(BOOL)ascending attributes:(NSArray *)attributesToSortBy
{
    NSMutableArray *attributes = [NSMutableArray array];
    
    for (NSString *attributeName in attributesToSortBy) 
    {
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:attributeName ascending:ascending];
        [attributes addObject:sortDescriptor];
    }
    
    return attributes;
}

+ (NSArray *) MR_ascendingSortDescriptors:(NSArray *)attributesToSortBy
{
    return [self MR_sortAscending:YES attributes:attributesToSortBy];
}

+ (NSArray *) MR_descendingSortDescriptors:(NSArray *)attributesToSortBy
{
    return [self MR_sortAscending:NO attributes:attributesToSortBy];
}

#pragma mark -

+ (instancetype) MR_createEntityInContext:(NSManagedObjectContext *)context
{
    NSEntityDescription *entity = [self MR_entityDescriptionInContext:context];
        
    if (entity == nil)
    {
        return nil;
    }
        
    return [[self alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
}

- (BOOL) MR_deleteEntityInContext:(NSManagedObjectContext *)context
{
    NSError *error = nil;
    NSManagedObject *entityInContext = [context existingObjectWithID:self.objectID error:&error];
    [NotSoMagicalRecord handleErrors:error];
    if (entityInContext) {
        [context deleteObject:entityInContext];
    }

    return YES;
}

- (BOOL) MR_deleteEntity
{
    [self MR_deleteEntityInContext:self.managedObjectContext];
    return YES;
}

+ (BOOL) MR_deleteAllMatchingPredicate:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [self MR_requestAllWithPredicate:predicate inContext:context];
    [request setReturnsObjectsAsFaults:YES];
    [request setIncludesPropertyValues:NO];
    
    NSArray *objectsToTruncate = [self MR_executeFetchRequest:request inContext:context];
    
    for (id objectToTruncate in objectsToTruncate) 
    {
        [objectToTruncate MR_deleteEntityInContext:context];
    }
    
    return YES;
}

+ (BOOL) MR_truncateAllInContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [self MR_requestAllInContext:context];
    [request setReturnsObjectsAsFaults:YES];
    [request setIncludesPropertyValues:NO];

    NSArray *objectsToDelete = [self MR_executeFetchRequest:request inContext:context];
    for (NSManagedObject *objectToDelete in objectsToDelete)
    {
        [objectToDelete MR_deleteEntityInContext:context];
    }
    return YES;
}

@end

