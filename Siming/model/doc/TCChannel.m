//
//  TCChannel.m
//  Siming
//
//  Created by taocore on 13-2-25.
//  Copyright (c) 2013年 taocore. All rights reserved.
//

#import "TCChannel.h"

@implementation TCChannel

+ (TCChannel*)channelWithElement:(TBXMLElement*) channelElement
{
    TCChannel* channel = [[TCChannel alloc] init];
    TBXMLElement* channelId = [TBXML childElementNamed:@"channelid" parentElement:channelElement];
    if (channelId)
    {
        channel.channelId = [TBXML textForElement:channelId];
    }
    TBXMLElement* name = [TBXML childElementNamed:@"chnldesc" parentElement:channelElement];
    if (name)
    {
        channel.name = [TBXML textForElement:name];
    }
    return channel;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"channelId: %@, name: %@", self.channelId, self.name];
}

@end
