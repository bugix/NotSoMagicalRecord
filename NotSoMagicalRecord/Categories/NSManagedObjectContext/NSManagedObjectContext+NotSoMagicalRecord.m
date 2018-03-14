//
//  NSManagedObjectContext+MagicalRecord.m
//
//  Created by Saul Mora on 11/23/09.
//  Copyright 2010 Magical Panda Software, LLC All rights reserved.
//

#import "NSManagedObjectContext+NotSoMagicalRecord.h"
#import "NotSoMagicalRecord+ErrorHandling.h"
#import "NotSoMagicalRecordLogging.h"

static id MagicalRecordUbiquitySetupNotificationObserver;

@implementation NSManagedObjectContext (NotSoMagicalRecord)

#pragma mark - Setup

#pragma mark - Default Contexts

- (void) MR_deleteObjects:(id <NSFastEnumeration>)objects
{
    for (NSManagedObject *managedObject in objects)
    {
        [self deleteObject:managedObject];
    }
}

@end

