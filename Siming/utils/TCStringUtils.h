//
//  TCStringUtils.h
//  Siming
//
//  Created by taocore on 13-2-28.
//  Copyright (c) 2013年 taocore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCStringUtils : NSObject

+ (NSString*)URLencode:(NSString *)originalString
        stringEncoding:(NSStringEncoding)stringEncoding;

@end
