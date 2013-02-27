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
    }
    TBXMLElement* docPubUrl = [TBXML childElementNamed:@"docpuburl" parentElement:docElement];
    if (docPubUrl)
    {
        doc.docPubUrl = [TBXML textForElement:docPubUrl];
    }
    TBXMLElement* content = [TBXML childElementNamed:@"content" parentElement:docElement];
    if (content)
    {
        doc.content = [TBXML textForElement:content];
    }
    TBXMLElement* createDate = [TBXML childElementNamed:@"createdate" parentElement:docElement];
    if (createDate)
    {
        doc.createDate = [TBXML textForElement:createDate];
    }
    return doc;
}

- (BOOL)hasImage
{
    return self.imagePath && [self.imagePath stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length > 0;
}

- (NSString*)imageAbsolutePath
{
    NSString* docUrl = self.docPubUrl;
    NSString* baseUrl = [docUrl stringByDeletingLastPathComponent];
    return [baseUrl stringByAppendingPathComponent:self.imagePath];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"title: %@; image: %@", self.title, self.imagePath];
}

@end
