//
//  TCMoreNewsViewController.m
//  Siming
//
//  Created by taocore on 13-2-26.
//  Copyright (c) 2013年 taocore. All rights reserved.
//

#import "TCMoreNewsViewController.h"
#import "TCChannel.h"
#import "TCDocItemsViewController.h"
#import "TCCommon.h"

@interface TCMoreNewsViewController ()

@property (copy, nonatomic) NSArray* channels;

@end

@implementation TCMoreNewsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.title = @"新闻公告";
        NSMutableArray* channels = [NSMutableArray arrayWithCapacity:5];
        TCChannel* channel = [[TCChannel alloc] init];
        channel.channelId = @"2340";
        channel.name = @"今日思明";
        [channels addObject:channel];
        channel = [[TCChannel alloc] init];
        channel.channelId = @"2341";
        channel.name = @"事要公告";
        [channels addObject:channel];
        channel = [[TCChannel alloc] init];
        channel.channelId = @"2342";
        channel.name = @"工作动态";
        [channels addObject:channel];
        channel = [[TCChannel alloc] init];
        channel.channelId = @"2344";
        channel.name = @"媒体聚焦";
        [channels addObject:channel];
        channel = [[TCChannel alloc] init];
        channel.channelId = @"2345";
        channel.name = @"图片新闻";
        [channels addObject:channel];
        _channels = channels;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.channels.count;
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
    TCChannel* channel = self.channels[indexPath.row];
    cell.textLabel.text = channel.name;
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TCChannel* channel = self.channels[indexPath.row];
    NSLog(@"%@", channel);
    NSString* url = @"http://www.siming.gov.cn:8090/smhdphone/common/jdbcNoPageResponse.as?_in=phonewcm@201";
    //NSData* data = [[NSData alloc] initWithContentsOfURL:url];
    //NSLog(@"data: %@", [NSString stringWithContentsOfURL:[NSURL URLWithString:url] encoding:NSUTF8StringEncoding error:nil]);
    TCDocItemsViewController* controller = [[TCDocItemsViewController alloc] initWithNibName:nil bundle:nil];
    controller.url = url;
    controller.detailsUrl = @"http://www.siming.gov.cn:8090/smhdphone/common/jdbcObjectResponse.as?_in=phonewcm@105";
    controller.channelId = channel.channelId;
    controller.title = channel.name;
    [self.navigationController pushViewController:controller animated:YES];
}

@end
