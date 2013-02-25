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
        self.list = channels;
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
    NSString* url = [NSString stringWithFormat:@"http://www.siming.gov.cn:8090/smhdphone/common/jdbcNoPageResponse.as?_in=phonewcm@201&pageSize=5&channelId=%@", channel.channelId];
    //NSData* data = [[NSData alloc] initWithContentsOfURL:url];
    //NSLog(@"data: %@", [NSString stringWithContentsOfURL:[NSURL URLWithString:url] encoding:NSUTF8StringEncoding error:nil]);
    [TBXML newTBXMLWithURL:[NSURL URLWithString:url]
                   success:^(TBXML *tbxml){
                       NSMutableArray* docs = [NSMutableArray array];
                       if (tbxml.rootXMLElement) {
                           TBXMLElement* object = [TBXML childElementNamed:@"object" parentElement:tbxml.rootXMLElement];
                           if (object)
                           {
                               TCDoc* doc = [TCDoc docWithElement:object];
                               [docs addObject:doc];
                               while ((object = [TBXML nextSiblingNamed:@"object" searchFromElement:object]))
                               {
                                   TCDoc* doc = [TCDoc docWithElement:object];
                                   [docs addObject:doc];
                               }
                           }
                       }
                       NSLog(@"docs: %@", docs);
                   }
                   failure:^(TBXML* tbxml, NSError* error){
                       
                   }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
