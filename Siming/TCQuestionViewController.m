//
//  TCQuestionViewController.m
//  Siming
//
//  Created by mac on 13-2-1.
//  Copyright (c) 2013年 taocore. All rights reserved.
//

#import "TCQuestionViewController.h"
#import "MBProgressHUD.h"
#import "TBXML.h"
#import "TBXML+Compression.h"
#import "TBXML+HTTP.h"
#import "TCDoc.h"

@interface TCQuestionViewController ()

@property (copy, nonatomic) NSArray* docs;

@end

@implementation TCQuestionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"公众参与";
        self.tabBarItem.image = [UIImage imageNamed:@"msfw"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self loadData];
}

- (void)loadData
{
    //MBProgressHUD* hud =
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __block TCQuestionViewController* weakSelf = self;
    NSString* url = @"http://www.siming.gov.cn:8090/smhdphone/common/jdbcPageResponse.as?_in=phonequestion@001";
    url = [url stringByAppendingFormat:@"&pageSize=%d", 10];
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    // Configure the cell...
    TCDoc* doc = self.docs[indexPath.row];
    cell.textLabel.text = doc.title;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@        时间：%@", doc.docType, doc.createDate];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TCDoc* doc = self.docs[indexPath.row];
    NSLog(@"%@", doc);
    /*TCDocDetailsViewController* controller = [[TCDocDetailsViewController alloc] initWithNibName:nil bundle:nil];
    controller.detailsUrl = self.detailsUrl;
    controller.docId = doc.docId;
    controller.channelId = self.channelId;
    controller.docTitle = doc.title;
    [self.navigationController pushViewController:controller animated:YES];*/
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
