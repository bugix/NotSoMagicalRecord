//
//  NSManagedObject+MagicalAggregation.m
//  Magical Record
//
//  Created by Saul Mora on 3/7/12.
//  Copyright (c) 2012 Magical Panda Software LLC. All rights reserved.
//

#import "NSManagedObject+MagicalAggregation.h"
#import "NSManagedObjectContext+NotSoMagicalRecord.h"
#import "NSManagedObject+MagicalRequests.h"
#import "NSManagedObject+NotSoMagicalRecord.h"
#import "NSManagedObject+MagicalFinders.h"
#import "NotSoMagicalRecord+ErrorHandling.h"

@implementation NSManagedObject (MagicalAggregation)

#pragma mark -
#pragma mark Number of Entities

+ (NSNumber *) MR_numberOfEntitiesWithContext:(NSManagedObjectContext *)context
{
    return @([self MR_countOfEntitiesWithContext:context]);
}

+ (NSNumber *) MR_numberOfEntitiesWithPredicate:(NSPredicate *)searchTerm inContext:(NSManagedObjectContext *)context
{
    return @([self MR_countOfEntitiesWithPredicate:searchTerm inContext:context]);
}

+ (NSUInteger) MR_countOfEntitiesWithContext:(NSManagedObjectContext *)context;
{
    return [self MR_countOfEntitiesWithPredicate:nil inContext:context];
}

+ (NSUInteger) MR_countOfEntitiesWithPredicate:(NSPredicate *)searchFilter inContext:(NSManagedObjectContext *)context;
{
    NSError *error = nil;
    NSFetchRequest *request = [self MR_createFetchRequestInContext:context];

    if (searchFilter)
    {
        request.predicate = searchFilter;
    }
    
    NSUInteger count = [context countForFetchRequest:request error:&error];
    [NotSoMagicalRecord handleErrors:error];
    
    return count;
}

+ (BOOL) MR_hasAtLeastOneEntityInContext:(NSManagedObjectContext *)context
{
    return [self MR_numberOfEntitiesWithContext:context].intValue > 0;
}

- (instancetype) MR_objectWithMinValueFor:(NSString *)property inContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [[self class] MR_createFetchRequestInContext:context];
    
    NSPredicate *searchFor = [NSPredicate predicateWithFormat:@"SELF = %@ AND %K = min(%@)", self, property, property];
    request.predicate = searchFor;
    
    return [[self class] MR_executeFetchRequestAndReturnFirstObject:request inContext:context];
}

- (instancetype) MR_objectWithMinValueFor:(NSString *)property
{
    return [self MR_objectWithMinValueFor:property inContext:self.managedObjectContext];
}

@end
