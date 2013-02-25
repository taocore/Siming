//
//  TCDocItemsViewController.h
//  Siming
//
//  Created by taocore on 13-2-25.
//  Copyright (c) 2013年 taocore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCDocItemsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (copy, nonatomic) NSArray* docs;

@end
