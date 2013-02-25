//
//  TCChannel.m
//  Siming
//
//  Created by taocore on 13-2-25.
//  Copyright (c) 2013年 taocore. All rights reserved.
//

#import "TCChannel.h"

@implementation TCChannel

- (NSString *)description
{
    return [NSString stringWithFormat:@"channelId: %@, name: %@", self.channelId, self.name];
}

@end
