//
//  TCTicket.m
//  Siming
//
//  Created by mac on 13-2-28.
//  Copyright (c) 2013年 taocore. All rights reserved.
//

#import "TCTicket.h"

@implementation TCTicket

+ (TCTicket*)ticketWithElement:(TBXMLElement*) ticketElement
{
    TCTicket* ticket = [[TCTicket alloc] init];
    TBXMLElement* ticketId = [TBXML childElementNamed:@"docid" parentElement:ticketElement];
    if (ticketId)
    {
        ticket.ticketId = [TBXML textForElement:ticketId];
    }
    TBXMLElement* title = [TBXML childElementNamed:@"title" parentElement:ticketElement];
    if (title)
    {
        ticket.title = [TBXML textForElement:title];
    }
    TBXMLElement* department = [TBXML childElementNamed:@"department" parentElement:ticketElement];
    if (department)
    {
        ticket.department = [TBXML textForElement:department];
    }
    TBXMLElement* accessDate = [TBXML childElementNamed:@"accessdate" parentElement:ticketElement];
    if (accessDate)
    {
        ticket.accessDate = [TBXML textForElement:accessDate];
    }
    TBXMLElement* content = [TBXML childElementNamed:@"content" parentElement:ticketElement];
    if (content)
    {
        ticket.content = [TBXML textForElement:content];
    }
    TBXMLElement* createDate = [TBXML childElementNamed:@"createdate" parentElement:ticketElement];
    if (createDate)
    {
        ticket.createDate = [TBXML textForElement:createDate];
    }
    TBXMLElement* type = [TBXML childElementNamed:@"type" parentElement:ticketElement];
    if (type)
    {
        ticket.type = [TBXML textForElement:type];
    }
    TBXMLElement* accessLimit = [TBXML childElementNamed:@"accesslimit" parentElement:ticketElement];
    if (accessLimit)
    {
        ticket.accessLimit = [TBXML textForElement:accessLimit];
    }
    TBXMLElement* reply = [TBXML childElementNamed:@"reply" parentElement:ticketElement];
    if (reply)
    {
        ticket.reply = [TBXML textForElement:reply];
    }
    TBXMLElement* replyDate = [TBXML childElementNamed:@"replydate" parentElement:ticketElement];
    if (replyDate)
    {
        ticket.replyDate = [TBXML textForElement:replyDate];
    }
    
    return ticket;
}

@end
