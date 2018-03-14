//
//  NSManagedObjectContext+MagicalRecord.h
//
//  Created by Saul Mora on 11/23/09.
//  Copyright 2010 Magical Panda Software, LLC All rights reserved.
//

#import <CoreData/CoreData.h>
#import <NotSoMagicalRecord/NotSoMagicalRecordXcode7CompatibilityMacros.h>

@interface NSManagedObjectContext (NotSoMagicalRecord)

/**
 Delete the provided objects from the context

 @param objects An object conforming to `NSFastEnumeration`, containing NSManagedObject instances
 */
- (void) MR_deleteObjects:(MR_nonnull id <NSFastEnumeration>)objects;

@end

