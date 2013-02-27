//
//  TCOfficeViewController.m
//  Siming
//
//  Created by mac on 13-2-1.
//  Copyright (c) 2013年 taocore. All rights reserved.
//

#import "TCOfficeViewController.h"
#import "TCChannel.h"
#import "TCDocItemsViewController.h"

@interface TCOfficeViewController ()

@property (copy, nonatomic) NSArray* channels;

@end

@implementation TCOfficeViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"网上办事";
        self.tabBarItem.image = [UIImage imageNamed:@"szxx"];
        NSMutableArray* channels = [NSMutableArray arrayWithCapacity:5];
        TCChannel* channel = [[TCChannel alloc] init];
        channel.channelId = @"5504";
        channel.name = @"发改局";
        [channels addObject:channel];
        channel = [[TCChannel alloc] init];
        channel.channelId = @"5509";
        channel.name = @"经贸局";
        [channels addObject:channel];
        channel = [[TCChannel alloc] init];
        channel.channelId = @"5508";
        channel.name = @"教育局";
        [channels addObject:channel];
        channel = [[TCChannel alloc] init];
        channel.channelId = @"5523";
        channel.name = @"科技局";
        [channels addObject:channel];
        channel = [[TCChannel alloc] init];
        channel.channelId = @"5524";
        channel.name = @"监察局";
        [channels addObject:channel];
        channel = [[TCChannel alloc] init];
        channel.channelId = @"5513";
        channel.name = @"民政局";
        [channels addObject:channel];
        channel = [[TCChannel alloc] init];
        channel.channelId = @"5525";
        channel.name = @"司法局";
        [channels addObject:channel];
        channel = [[TCChannel alloc] init];
        channel.channelId = @"5512";
        channel.name = @"财政局";
        [channels addObject:channel];
        channel = [[TCChannel alloc] init];
        channel.channelId = @"5516";
        channel.name = @"审计局";
        [channels addObject:channel];
        channel = [[TCChannel alloc] init];
        channel.channelId = @"5520";
        channel.name = @"人劳社保局";
        [channels addObject:channel];
        channel = [[TCChannel alloc] init];
        channel.channelId = @"5511";
        channel.name = @"计生局";
        [channels addObject:channel];
        channel = [[TCChannel alloc] init];
        channel.channelId = @"5515";
        channel.name = @"卫生局";
        [channels addObject:channel];
        channel = [[TCChannel alloc] init];
        channel.channelId = @"5507";
        channel.name = @"建设局";
        [channels addObject:channel];
        channel = [[TCChannel alloc] init];
        channel.channelId = @"5519";
        channel.name = @"文体出版局";
        [channels addObject:channel];
        channel = [[TCChannel alloc] init];
        channel.channelId = @"5517";
        channel.name = @"投资促进局";
        [channels addObject:channel];
        channel = [[TCChannel alloc] init];
        channel.channelId = @"5518";
        channel.name = @"外事侨务办";
        [channels addObject:channel];
        channel = [[TCChannel alloc] init];
        channel.channelId = @"5522";
        channel.name = @"城管行政执法局";
        [channels addObject:channel];
        channel = [[TCChannel alloc] init];
        channel.channelId = @"5514";
        channel.name = @"旅游园林局";
        [channels addObject:channel];
        channel = [[TCChannel alloc] init];
        channel.channelId = @"5505";
        channel.name = @"统计局";
        [channels addObject:channel];
        channel = [[TCChannel alloc] init];
        channel.channelId = @"5506";
        channel.name = @"安监局";
        [channels addObject:channel];
        channel = [[TCChannel alloc] init];
        channel.channelId = @"5526";
        channel.name = @"工业园区管委会";
        [channels addObject:channel];
        channel = [[TCChannel alloc] init];
        channel.channelId = @"5510";
        channel.name = @"民宗局";
        [channels addObject:channel];
        channel = [[TCChannel alloc] init];
        channel.channelId = @"5528";
        channel.name = @"残联";
        [channels addObject:channel];
        channel = [[TCChannel alloc] init];
        channel.channelId = @"5521";
        channel.name = @"思明公安分局";
        [channels addObject:channel];
        channel = [[TCChannel alloc] init];
        channel.channelId = @"5529";
        channel.name = @"思明区工商局";
        [channels addObject:channel];
        _channels = channels;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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
    controller.detailsUrl = @"http://www.siming.gov.cn:8090/smhdphone/common/jdbcObjectResponse.as?_in=phonewcm@106";
    controller.channelId = channel.channelId;
    controller.title = channel.name;
    [self.navigationController pushViewController:controller animated:YES];
}

@end
