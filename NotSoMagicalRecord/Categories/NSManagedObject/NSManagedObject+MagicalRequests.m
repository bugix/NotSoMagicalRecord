//
//  NSManagedObject+MagicalRequests.m
//  Magical Record
//
//  Created by Saul Mora on 3/7/12.
//  Copyright (c) 2012 Magical Panda Software LLC. All rights reserved.
//

#import "NSManagedObject+MagicalRequests.h"
#import "NSManagedObject+NotSoMagicalRecord.h"

@implementation NSManagedObject (MagicalRequests)


+ (NSFetchRequest *)MR_createFetchRequestInContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [self MR_entityDescriptionInContext:context];
    
    return request;
}

+ (NSFetchRequest *) MR_requestAllInContext:(NSManagedObjectContext *)context
{
    return [self MR_createFetchRequestInContext:context];
}

+ (NSFetchRequest *) MR_requestAllWithPredicate:(NSPredicate *)searchTerm inContext:(NSManagedObjectContext *)context;
{
    NSFetchRequest *request = [self MR_createFetchRequestInContext:context];
    request.predicate = searchTerm;
    
    return request;
}

+ (NSFetchRequest *) MR_requestAllWhere:(NSString *)property isEqualTo:(id)value inContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [self MR_createFetchRequestInContext:context];
    request.predicate = [NSPredicate predicateWithFormat:@"%K = %@", property, value];
    
    return request;
}

+ (NSFetchRequest *) MR_requestFirstWithPredicate:(NSPredicate *)searchTerm inContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [self MR_createFetchRequestInContext:context];
    request.predicate = searchTerm;
    request.fetchLimit = 1;
    
    return request;
}

+ (NSFetchRequest *) MR_requestFirstByAttribute:(NSString *)attribute withValue:(id)searchValue inContext:(NSManagedObjectContext *)context;
{
    NSFetchRequest *request = [self MR_requestAllWhere:attribute isEqualTo:searchValue inContext:context]; 
    request.fetchLimit = 1;
    
    return request;
}

+ (NSFetchRequest *) MR_requestAllSortedBy:(NSString *)sortTerm ascending:(BOOL)ascending inContext:(NSManagedObjectContext *)context
{
    return [self MR_requestAllSortedBy:sortTerm
                             ascending:ascending
                         withPredicate:nil
                             inContext:context];
}

+ (NSFetchRequest *) MR_requestAllSortedBy:(NSString *)sortTerm ascending:(BOOL)ascending withPredicate:(NSPredicate *)searchTerm inContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [self MR_requestAllInContext:context];
    if (searchTerm)
    {
        request.predicate = searchTerm;
    }
    request.fetchBatchSize = [self MR_defaultBatchSize];
    
    NSMutableArray* sortDescriptors = [[NSMutableArray alloc] init];
    NSArray* sortKeys = [sortTerm componentsSeparatedByString:@","];
    for (__strong NSString* sortKey in sortKeys)
    {
        BOOL localAscending = ascending;

        NSArray * sortComponents = [sortKey componentsSeparatedByString:@":"];
        if (sortComponents.count > 1)
        {
            NSString *customAscending = sortComponents.lastObject;
            localAscending = customAscending.boolValue;
            sortKey = sortComponents[0];
        }
      
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sortKey ascending:localAscending];
        [sortDescriptors addObject:sortDescriptor];
    }
    
    request.sortDescriptors = sortDescriptors;
    
    return request;
}

@end
