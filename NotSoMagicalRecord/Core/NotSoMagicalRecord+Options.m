//
//  MagicalRecord+Options.m
//  Magical Record
//
//  Created by Saul Mora on 3/6/12.
//  Copyright (c) 2012 Magical Panda Software LLC. All rights reserved.
//

#import "NotSoMagicalRecord+Options.h"

#ifdef DEBUG
static NotSoMagicalRecordLoggingLevel kMagicalRecordLoggingLevel = NotSoMagicalRecordLoggingLevelDebug;
#else
static NotSoMagicalRecordLoggingLevel kMagicalRecordLoggingLevel = NotSoMagicalRecordLoggingLevelError;
#endif

@implementation NotSoMagicalRecord (Options)

+ (NotSoMagicalRecordLoggingLevel) loggingLevel;
{
    return kMagicalRecordLoggingLevel;
}

+ (void) setLoggingLevel:(NotSoMagicalRecordLoggingLevel)level;
{
    kMagicalRecordLoggingLevel = level;
}

@end
