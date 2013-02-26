//
//  TCDocDetailsViewController.h
//  Siming
//
//  Created by mac on 13-2-26.
//  Copyright (c) 2013年 taocore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCDocDetailsViewController : UIViewController

@property (copy, nonatomic) NSString* detailsUrl;
@property (copy, nonatomic) NSString* docId;
@property (copy, nonatomic) NSString* channelId;
@property (copy, nonatomic) NSString* docTitle;

@end
