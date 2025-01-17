#ifdef __OBJC__
#import <Cocoa/Cocoa.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "EXPBlockDefinedMatcher.h"
#import "EXPDefines.h"
#import "EXPDoubleTuple.h"
#import "Expecta.h"
#import "ExpectaObject.h"
#import "ExpectaSupport.h"
#import "EXPExpect.h"
#import "EXPFloatTuple.h"
#import "EXPMatcher.h"
#import "EXPUnsupportedObject.h"
#import "EXPMatcherHelpers.h"
#import "EXPMatchers+beCloseTo.h"
#import "EXPMatchers+beFalsy.h"
#import "EXPMatchers+beginWith.h"
#import "EXPMatchers+beGreaterThan.h"
#import "EXPMatchers+beGreaterThanOrEqualTo.h"
#import "EXPMatchers+beIdenticalTo.h"
#import "EXPMatchers+beInstanceOf.h"
#import "EXPMatchers+beInTheRangeOf.h"
#import "EXPMatchers+beKindOf.h"
#import "EXPMatchers+beLessThan.h"
#import "EXPMatchers+beLessThanOrEqualTo.h"
#import "EXPMatchers+beNil.h"
#import "EXPMatchers+beSubclassOf.h"
#import "EXPMatchers+beSupersetOf.h"
#import "EXPMatchers+beTruthy.h"
#import "EXPMatchers+conformTo.h"
#import "EXPMatchers+contain.h"
#import "EXPMatchers+endWith.h"
#import "EXPMatchers+equal.h"
#import "EXPMatchers+haveCountOf.h"
#import "EXPMatchers+match.h"
#import "EXPMatchers+postNotification.h"
#import "EXPMatchers+raise.h"
#import "EXPMatchers+raiseWithReason.h"
#import "EXPMatchers+respondTo.h"
#import "EXPMatchers.h"
#import "NSObject+Expecta.h"
#import "NSValue+Expecta.h"

FOUNDATION_EXPORT double ExpectaVersionNumber;
FOUNDATION_EXPORT const unsigned char ExpectaVersionString[];

