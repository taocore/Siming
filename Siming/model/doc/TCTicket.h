//
//  TCTicket.h
//  Siming
//
//  Created by mac on 13-2-28.
//  Copyright (c) 2013年 taocore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBXML.h"

@interface TCTicket : NSObject

@property (copy, nonatomic) NSString* ticketId;
@property (copy, nonatomic) NSString* type;
@property (copy, nonatomic) NSString* title;
@property (copy, nonatomic) NSString* createDate;
@property (copy, nonatomic) NSString* content;
@property (copy, nonatomic) NSString* department;
@property (copy, nonatomic) NSString* accessDate;
@property (copy, nonatomic) NSString* accessLimit;
@property (copy, nonatomic) NSString* replyDate;
@property (copy, nonatomic) NSString* reply;

+ (TCTicket*)ticketWithElement:(TBXMLElement*) ticketElement;

@end
