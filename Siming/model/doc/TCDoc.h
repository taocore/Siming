//
//  TCDoc.h
//  Siming
//
//  Created by taocore on 13-2-22.
//  Copyright (c) 2013年 taocore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBXML.h"

@interface TCDoc : NSObject

@property (copy, nonatomic) NSString* docId;
@property (copy, nonatomic) NSString* title;
@property (copy, nonatomic) NSString* imagePath;
@property (copy, nonatomic) NSString* docPubUrl;

+ (TCDoc*)docWithElement:(TBXMLElement*) docElement;

@end
