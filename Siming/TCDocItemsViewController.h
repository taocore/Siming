//
//  TCDocItemsViewController.h
//  Siming
//
//  Created by taocore on 13-2-25.
//  Copyright (c) 2013年 taocore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCDocItemsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (copy, nonatomic) NSString* url;
@property (copy, nonatomic) NSString* detailsUrl;
@property (nonatomic) NSUInteger pageSize;
@property (copy, nonatomic) NSString* channelId;
@property (copy, nonatomic) NSArray* docs;

@end
