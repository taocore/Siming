//
//  TCSecondViewController.m
//  Siming
//
//  Created by mac on 13-2-1.
//  Copyright (c) 2013年 taocore. All rights reserved.
//

#import "TCPublicViewController.h"
#import "TCCommon.h"
#import "TCChannel.h"
#import "TBXML.h"
#import "TBXML+HTTP.h"
#import "TBXML+Compression.h"
#import "TCDoc.h"
#import "TCDocItemsViewController.h"
#import "TCChannelsViewController.h"
#import "TCPublicSuggestionSubmitViewController.h"

@interface TCPublicViewController ()

@property (copy, nonatomic) NSArray* list;
@property (strong, nonatomic) UITableView* tableView;

@end

@implementation TCPublicViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"信息公开";
        self.tabBarItem.image = [UIImage imageNamed:@"xxgk"];
        NSMutableArray* channels = [NSMutableArray arrayWithCapacity:5];
        TCChannel* channel = [[TCChannel alloc] init];
        channel.channelId = @"2001";
        channel.name = @"信息公开指南";
        [channels addObject:channel];
        channel = [[TCChannel alloc] init];
        channel.channelId = @"2746";
        channel.name = @"信息公开年度报告";
        [channels addObject:channel];
        channel = [[TCChannel alloc] init];
        channel.channelId = @"4187";
        channel.name = @"信息公开意见箱";
        [channels addObject:channel];
        channel = [[TCChannel alloc] init];
        channel.channelId = @"2040";
        channel.name = @"信息公开制度规定";
        [channels addObject:channel];
        channel = [[TCChannel alloc] init];
        channel.channelId = @"2002";
        channel.name = @"信息公开目录";
        [channels addObject:channel];
        _list = channels;
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kMainViewHeight) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    // Configure the cell...
    TCChannel* channel = self.list[indexPath.row];
    cell.textLabel.text = channel.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TCChannel* channel = self.list[indexPath.row];
    NSLog(@"%@", channel);
    if ([@"2002" isEqualToString:channel.channelId])
    {
        NSString* url = @"http://www.siming.gov.cn:8090/smhdphone/common/jdbcNoPageResponse.as?_in=phonewcm@203";
        //NSData* data = [[NSData alloc] initWithContentsOfURL:url];
        //NSLog(@"data: %@", [NSString stringWithContentsOfURL:[NSURL URLWithString:url] encoding:NSUTF8StringEncoding error:nil]);
        TCChannelsViewController* controller = [[TCChannelsViewController alloc] initWithNibName:nil bundle:nil];
        controller.url = url;
        controller.detailsUrl = @"http://www.siming.gov.cn:8090/smhdphone/common/jdbcObjectResponse.as?_in=phonewcm@106";
        controller.parentChannelId = channel.channelId;
        controller.title = channel.name;
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if ([@"4187" isEqualToString:channel.channelId])
    {
        TCPublicSuggestionSubmitViewController* controller = [[TCPublicSuggestionSubmitViewController alloc] initWithNibName:@"TCPublicSuggestionSubmitViewController" bundle:nil];
        
        [self.navigationController pushViewController:controller animated:YES];
    }
    else
    {
        NSString* url = @"http://www.siming.gov.cn:8090/smhdphone/common/jdbcNoPageResponse.as?_in=phonewcm@201";
        //NSData* data = [[NSData alloc] initWithContentsOfURL:url];
        //NSLog(@"data: %@", [NSString stringWithContentsOfURL:[NSURL URLWithString:url] encoding:NSUTF8StringEncoding error:nil]);
        TCDocItemsViewController* controller = [[TCDocItemsViewController alloc] initWithNibName:nil bundle:nil];
        controller.url = url;
        controller.detailsUrl = @"http://www.siming.gov.cn:8090/smhdphone/common/jdbcObjectResponse.as?_in=phonewcm@106";
        controller.channelId = channel.channelId;
        controller.title = channel.name;
        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
