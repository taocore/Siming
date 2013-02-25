//
//  TCDoc.m
//  Siming
//
//  Created by taocore on 13-2-22.
//  Copyright (c) 2013年 taocore. All rights reserved.
//

#import "TCDoc.h"

@implementation TCDoc

+ (TCDoc*)docWithElement:(TBXMLElement*) docElement
{
    TCDoc* doc = [[TCDoc alloc] init];
    TBXMLElement* docId = [TBXML childElementNamed:@"docid" parentElement:docElement];
    if (docId)
    {
        doc.docId = [TBXML textForElement:docId];
    }
    TBXMLElement* title = [TBXML childElementNamed:@"title" parentElement:docElement];
    if (title)
    {
        doc.title = [TBXML textForElement:title];
    }
    TBXMLElement* imagePath = [TBXML childElementNamed:@"imagepath" parentElement:docElement];
    if (imagePath)
    {
        doc.imagePath = [TBXML textForElement:imagePath];
        NSLog(@"imagePath: %@", doc.imagePath);
    }
    TBXMLElement* docPubUrl = [TBXML childElementNamed:@"docpuburl" parentElement:docElement];
    if (docPubUrl)
    {
        doc.docPubUrl = [TBXML textForElement:docPubUrl];
    }
    return doc;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"title: %@", self.title];
}

@end
