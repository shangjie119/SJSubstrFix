//
//  NSString+SJSubstrFix.h
//  SJSubstrFix_Example
//
//  Created by 尚杰 on 2022/7/10.
//  Copyright © 2022 494948246@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (SJSubstrFix)

/// 无效字符直接截取
- (NSString *)sj_substringWithRange_validSub:(NSRange)range;
/// 获取有效字符所有range截取
- (NSString *)sj_substringWithRange_validAll:(NSRange)range;


@end

NS_ASSUME_NONNULL_END
