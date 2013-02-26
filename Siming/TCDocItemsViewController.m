//
//  TCDocItemsViewController.m
//  Siming
//
//  Created by taocore on 13-2-25.
//  Copyright (c) 2013年 taocore. All rights reserved.
//

#import "TCDocItemsViewController.h"
#import "TCDoc.h"
#import "TBXML.h"
#import "TBXML+HTTP.h"
#import "TBXML+Compression.h"
#import "MBProgressHUD.h"
#import "TCCommon.h"

@interface TCDocItemsViewController ()

@property (strong, nonatomic) UITableView* tableView;

@end

@implementation TCDocItemsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        if (!_pageSize)
        {
            _pageSize = 10;
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kMainViewHeight) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    [self loadData];
}

- (void)loadData
{
    //MBProgressHUD* hud =
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __block TCDocItemsViewController* weakSelf = self;
    NSString* url = [self.url stringByAppendingFormat:@"&pageSize=%d&channelId=%@", self.pageSize, self.channelId];
    NSLog(@"url: %@", url);
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
                       weakSelf.docs = docs;
                       [weakSelf.tableView reloadData];
                       [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
                   }
                   failure:^(TBXML* tbxml, NSError* error){
                       NSLog(@"error: %@", error);
                   }];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(loadData)];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.docs.count;
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
    TCDoc* doc = self.docs[indexPath.row];
    cell.textLabel.text = doc.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TCDoc* doc = self.docs[indexPath.row];
    NSLog(@"%@", doc);
    NSString* url = [NSString stringWithFormat:@"http://www.siming.gov.cn:8090/smhdphone/common/jdbcNoPageResponse.as?_in=phonewcm@201&pageSize=5&channelId=%@", doc.docId];
    //NSData* data = [[NSData alloc] initWithContentsOfURL:url];
    NSLog(@"data: %@", [NSString stringWithContentsOfURL:[NSURL URLWithString:url] encoding:NSUTF8StringEncoding error:nil]);
    //todo: show doc details
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
