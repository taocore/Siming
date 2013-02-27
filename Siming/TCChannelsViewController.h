//
//  TCChannelsViewController.h
//  Siming
//
//  Created by taocore on 13-2-27.
//  Copyright (c) 2013年 taocore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCChannelsViewController : UITableViewController

@property (copy, nonatomic) NSString* url;
@property (copy, nonatomic) NSString* detailsUrl;
@property (copy, nonatomic) NSString* parentChannelId;
@property (copy, nonatomic) NSArray* channels;

@end
