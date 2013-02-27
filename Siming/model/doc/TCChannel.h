//
//  TCChannel.h
//  Siming
//
//  Created by taocore on 13-2-25.
//  Copyright (c) 2013年 taocore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBXML.h"

@interface TCChannel : NSObject

@property (copy, nonatomic) NSString* channelId;
@property (copy, nonatomic) NSString* name;
@property (copy, nonatomic) NSArray* docs;

+ (TCChannel*)channelWithElement:(TBXMLElement*) channelElement;

@end
