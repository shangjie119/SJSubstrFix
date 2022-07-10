//
//  NSString+SJSubstrFix.m
//  SJSubstrFix_Example
//
//  Created by 尚杰 on 2022/7/10.
//  Copyright © 2022 494948246@qq.com. All rights reserved.
//

#import "NSString+SJSubstrFix.h"
#import <objc/runtime.h>

@implementation NSString (SJSubstrFix)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method oldMethod1 = class_getInstanceMethod([self class], @selector(substringToIndex:));
        Method newMethod1 = class_getInstanceMethod([self class], @selector(sj_substringToIndex:));
        method_exchangeImplementations(oldMethod1, newMethod1);
        
        Method oldMethod2 = class_getInstanceMethod([self class], @selector(substringFromIndex:));
        Method newMethod2 = class_getInstanceMethod([self class], @selector(sj_substringFromIndex:));
        method_exchangeImplementations(oldMethod2, newMethod2);
        
        
        Method oldMethod3 = class_getInstanceMethod([self class], @selector(substringWithRange:));
        Method newMethod3 = class_getInstanceMethod([self class], @selector(sj_substringWithRange:));
        method_exchangeImplementations(oldMethod3, newMethod3);
    });
}

- (NSString *)sj_substringToIndex:(NSUInteger)to
{
    if (to <= 0) {
        return @"";
    }
    if (to > self.length) {
        return [self sj_substringToIndex:to];
    }
    NSRange lastRange = [self rangeOfComposedCharacterSequenceAtIndex:to - 1];
    if (lastRange.length > 1) {
        return [self sj_substringToIndex:lastRange.location];
    } else {
        return [self sj_substringToIndex:to];
    }

}

- (NSString *)sj_substringFromIndex:(NSUInteger)from
{
    if (from < 0) {
        return @"";
    }
    if (from >= self.length) {
        return [self sj_substringFromIndex:from];
    }
    NSRange firstRange = [self rangeOfComposedCharacterSequenceAtIndex:from];
    if (firstRange.location != from) {
        return [self sj_substringFromIndex:(firstRange.location + firstRange.length)];
    } else {
        return [self sj_substringFromIndex:from];
    }
}

- (NSString *)sj_substringWithRange_validSub:(NSRange)range
{
    if (range.length == 0 || range.location + range.length > self.length) {
        return @"";
    }

    NSInteger loc = range.location;
    NSInteger len = range.length;
    NSRange firstRange = [self rangeOfComposedCharacterSequenceAtIndex:loc];
    NSRange lastRange = [self rangeOfComposedCharacterSequenceAtIndex:loc + len - 1];
    
    if (firstRange.location != loc) {
        len -= (firstRange.location + firstRange.length - loc);
        loc = firstRange.location + firstRange.length;
    }
    if (lastRange.length > 1 && (lastRange.location + lastRange.length) > loc + len) {
        len = lastRange.location - loc;
    }
    if (len <= 0) {
        return @"";
    } else {
        return [self substringWithRange:NSMakeRange(loc, len)];
    }
}

- (NSString *)sj_substringWithRange_validAll:(NSRange)range
{
    NSRange newRange = [self rangeOfComposedCharacterSequencesForRange:range];
    return [self substringWithRange:newRange];
}

@end
