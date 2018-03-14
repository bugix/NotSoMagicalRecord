//
//  MagicalRecord+Options.h
//  Magical Record
//
//  Created by Saul Mora on 3/6/12.
//  Copyright (c) 2012 Magical Panda Software LLC. All rights reserved.
//

#import <NotSoMagicalRecord/NotSoMagicalRecordInternal.h>

/**
 Defines "levels" of logging that will be used as values in a bitmask that filters log messages.

 @since Available in v2.3 and later.
 */
typedef NS_ENUM (NSUInteger, NotSoMagicalRecordLoggingMask)
{
    /** Log all errors */
    NotSoMagicalRecordLoggingMaskError = 1 << 0,

    /** Log warnings, and all errors */
    NotSoMagicalRecordLoggingMaskWarn = 1 << 1,

    /** Log informative messagess, warnings and all errors */
    NotSoMagicalRecordLoggingMaskInfo = 1 << 2,

    /** Log debugging messages, informative messages, warnings and all errors */
    NotSoMagicalRecordLoggingMaskDebug = 1 << 3,

    /** Log verbose diagnostic information, debugging messages, informative messages, messages, warnings and all errors */
    NotSoMagicalRecordLoggingMaskVerbose = 1 << 4,
};

/**
 Defines a mask for logging that will be used by to filter log messages.

 @since Available in v2.3 and later.
 */
typedef NS_ENUM (NSUInteger, NotSoMagicalRecordLoggingLevel)
{
    /** Don't log anything */
    NotSoMagicalRecordLoggingLevelOff = 0,

    /** Log all errors and fatal messages */
    NotSoMagicalRecordLoggingLevelError = (NotSoMagicalRecordLoggingMaskError),

    /** Log warnings, errors and fatal messages */
    NotSoMagicalRecordLoggingLevelWarn = (NotSoMagicalRecordLoggingLevelError | NotSoMagicalRecordLoggingMaskWarn),

    /** Log informative, warning and error messages */
    NotSoMagicalRecordLoggingLevelInfo = (NotSoMagicalRecordLoggingLevelWarn | NotSoMagicalRecordLoggingMaskInfo),

    /** Log all debugging, informative, warning and error messages */
    NotSoMagicalRecordLoggingLevelDebug = (NotSoMagicalRecordLoggingLevelInfo | NotSoMagicalRecordLoggingMaskDebug),

    /** Log verbose diagnostic, debugging, informative, warning and error messages */
    NotSoMagicalRecordLoggingLevelVerbose = (NotSoMagicalRecordLoggingLevelDebug | NotSoMagicalRecordLoggingMaskVerbose),

    /** Log everything */
    NotSoMagicalRecordLoggingLevelAll = NSUIntegerMax
};


@interface NotSoMagicalRecord (Options)

/**
 @name Logging Levels
 */

/**
 Returns the logging mask set for MagicalRecord in the current application.

 @return Current MagicalRecordLoggingLevel
 
 @since Available in v2.3 and later.
 */
+ (NotSoMagicalRecordLoggingLevel) loggingLevel;

/**
 Sets the logging mask set for MagicalRecord in the current application.

 @param level Any value from MagicalRecordLogLevel

 @since Available in v2.3 and later.
 */
+ (void) setLoggingLevel:(NotSoMagicalRecordLoggingLevel)level;

@end
