//
//  MagicalRecord+ErrorHandling.h
//  Magical Record
//
//  Created by Saul Mora on 3/6/12.
//  Copyright (c) 2012 Magical Panda Software LLC. All rights reserved.
//

#import <NotSoMagicalRecord/NotSoMagicalRecordInternal.h>
#import <NotSoMagicalRecord/NotSoMagicalRecordXcode7CompatibilityMacros.h>

@interface NotSoMagicalRecord (ErrorHandling)

+ (void) handleErrors:(MR_nonnull NSError *)error;
- (void) handleErrors:(MR_nonnull NSError *)error;

+ (void) setErrorHandlerTarget:(MR_nullable id)target action:(MR_nonnull SEL)action;
+ (MR_nonnull SEL) errorHandlerAction;
+ (MR_nullable id) errorHandlerTarget;

@end
