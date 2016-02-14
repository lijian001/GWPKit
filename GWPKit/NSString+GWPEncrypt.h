//
//  NSString+GWPEncrypt.h
//  GWPEncrypt
//
//  Created by GWP on 15/6/2.
//  Copyright (c) 2015年 GWP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (GWPEncrypt)

/**
 *  32位MD5加密
 *
 *  @return 32位MD5加密结果
 */
- (NSString *)md5;


/**
 *  SHA1加密
 *
 *  @return SHA1加密结果
 */
- (NSString *)sha1;

@end
