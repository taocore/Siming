//
//  TCFirstViewController.m
//  Siming
//
//  Created by mac on 13-2-1.
//  Copyright (c) 2013年 taocore. All rights reserved.
//

#import "TCNewsViewController.h"
#import "TCCommon.h"
#import "TCDoc.h"
#import "TBXML.h"
#import "TBXML+Compression.h"
#import "TBXML+HTTP.h"
#import "UIImageView+WebCache.h"
#import "TCImagePage.h"
#import "MBProgressHUD.h"
#import "TCMoreNewsViewController.h"
#import "TCChannel.h"
#import "TCDocDetailsViewController.h"

@interface TCNewsViewController ()

@property (strong, nonatomic) UIScrollView* scrollView;
@property (strong, nonatomic) UITableView* tableView;
@property (strong, nonatomic) UIPageControl* pageControl;
@property (strong, nonatomic) NSMutableArray* imageDocs;
@property (copy, nonatomic) NSArray* sections;

@end

@implementation TCNewsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"新闻公告";
        self.tabBarItem.image = [UIImage imageNamed:@"fjyw"];
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
        _sections = channels;
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 160)];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    int pageNumber = 5;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * pageNumber, scrollView.frame.size.height);
    scrollView.delegate = self;
    NSUInteger pageWidth = scrollView.frame.size.width;
    for (int i = 0; i < 5; i++)
    {
        CGRect frame = scrollView.frame;
        frame.origin = CGPointMake(pageWidth * i, 0);
        TCImagePage *view = [[TCImagePage alloc] initWithFrame:frame];
        [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped:)]];
        [scrollView addSubview:view];
    }
    self.scrollView = scrollView;
    
    UIView* pageControlView = [[UIView alloc] initWithFrame:CGRectMake(0, 160, kDeviceWidth, 20)];
    pageControlView.backgroundColor = [UIColor blackColor];
    UIPageControl* pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 20)];
    pageControl.numberOfPages = pageNumber;
    pageControl.userInteractionEnabled = NO;
    [pageControlView addSubview:pageControl];
    self.pageControl = pageControl;
    
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 180)];
    [headerView addSubview:scrollView];
    [headerView addSubview:pageControlView];
        
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, kMainViewHeight - self.navigationController.navigationBar.frame.size.height - self.tabBarController.tabBar.frame.size.height) style:UITableViewStylePlain];
    self.tableView.tableHeaderView = headerView;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    [self loadData];
}

- (void)loadData
{
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"正在加载新闻，请稍候...";
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        // Do something...
        dispatch_async(dispatch_get_main_queue(), ^{
            
    NSString* imageDocsUrl = @"http://www.siming.gov.cn:8090/smhdphone/common/jdbcNoPageResponse.as?_in=phonewcm@101&pageSize=5&channelId=2345";
    /*__block TCNewsViewController* weakSelf = self;
    [TBXML newTBXMLWithURL:[NSURL URLWithString:imageDocsUrl]
                   success:^(TBXML *tbxml){
                       NSMutableArray* imageDocs = [NSMutableArray array];
                       if (tbxml.rootXMLElement) {
                           TBXMLElement* object = [TBXML childElementNamed:@"object" parentElement:tbxml.rootXMLElement];
                           if (object)
                           {
                               TCDoc* doc = [TCDoc docWithElement:object];
                               [imageDocs addObject:doc];
                               while ((object = [TBXML nextSiblingNamed:@"object" searchFromElement:object]))
                               {
                                   TCDoc* doc = [TCDoc docWithElement:object];
                                   [imageDocs addObject:doc];
                               }
                           }
                       }
                       NSLog(@"docs: %@", imageDocs);
                       int i = 0;
                       for (TCDoc* doc in imageDocs)
                       {
                           TCImagePage* imageView = self.scrollView.subviews[i++];
                           imageView.title = doc.title;
                           imageView.imageUrl = [doc imageAbsolutePath];
                       }
                       weakSelf.imageDocs = imageDocs;
                       for (TCChannel* chanel in weakSelf.sections)
                       {
                           NSString* url = @"http://www.siming.gov.cn:8090/smhdphone/common/jdbcNoPageResponse.as?_in=phonewcm@201";
                           url = [url stringByAppendingFormat:@"&pageSize=%d&channelId=%@", 5, chanel.channelId];
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
                                              chanel.docs = docs;
                                          }
                                          failure:^(TBXML* tbxml, NSError* error){
                                              NSLog(@"error: %@", error);
                                          }];
                       }
                       [weakSelf.tableView reloadData];
                       [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
                   }
                   failure:^(TBXML* tbxml, NSError* error){
                       
                   }];*/
    NSString* xml = [NSString stringWithContentsOfURL:[NSURL URLWithString:imageDocsUrl] encoding:NSUTF8StringEncoding error:nil];
    TBXML* tbxml = [TBXML newTBXMLWithXMLString:xml error:nil];
    NSMutableArray* imageDocs = [NSMutableArray array];
    if (tbxml.rootXMLElement) {
        TBXMLElement* object = [TBXML childElementNamed:@"object" parentElement:tbxml.rootXMLElement];
        if (object)
        {
            TCDoc* doc = [TCDoc docWithElement:object];
            [imageDocs addObject:doc];
            while ((object = [TBXML nextSiblingNamed:@"object" searchFromElement:object]))
            {
                TCDoc* doc = [TCDoc docWithElement:object];
                [imageDocs addObject:doc];
            }
        }
    }
    NSLog(@"docs: %@", imageDocs);
    int i = 0;
    for (TCDoc* doc in imageDocs)
    {
        TCImagePage* imageView = self.scrollView.subviews[i++];
        imageView.docId = doc.docId;
        imageView.title = doc.title;
        imageView.imageUrl = [doc imageAbsolutePath];
    }
    self.imageDocs = imageDocs;
    NSString* channelUrl = @"http://www.siming.gov.cn:8090/smhdphone/common/jdbcNoPageResponse.as?_in=phonewcm@201";
    for (TCChannel* chanel in self.sections)
    {
        NSString* url = [channelUrl stringByAppendingFormat:@"&pageSize=%d&channelId=%@", 5, chanel.channelId];
        NSLog(@"url: %@", url);
        NSString* xml = [NSString stringWithContentsOfURL:[NSURL URLWithString:url] encoding:NSUTF8StringEncoding error:nil];
        TBXML* tbxml = [TBXML newTBXMLWithXMLString:xml error:nil];
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
        chanel.docs = docs;
    }
    [self.tableView reloadData];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;
}

- (void)imageTapped:(UITapGestureRecognizer*)sender
{
    NSLog(@"sender: %@", sender);
    TCImagePage* view = (TCImagePage*)sender.view;
    TCDocDetailsViewController* controller = [[TCDocDetailsViewController alloc] initWithNibName:nil bundle:nil];
    controller.detailsUrl = @"http://www.siming.gov.cn:8090/smhdphone/common/jdbcObjectResponse.as?_in=phonewcm@105";
    controller.docId = view.docId;
    controller.channelId = @"2345";
    controller.docTitle = view.title;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"更多" style:UIBarButtonItemStyleBordered target:self action:@selector(more)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(loadData)];
}

- (void)more
{
    TCMoreNewsViewController* controller = [[TCMoreNewsViewController alloc] initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:controller animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sections.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return ((TCChannel*)self.sections[section]).name;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    TCChannel* chanel = self.sections[section];
    return chanel.docs.count;
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
    TCChannel* chanel = self.sections[indexPath.section];
    TCDoc* doc = chanel.docs[indexPath.row];
    cell.textLabel.text = doc.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TCChannel* chanel = self.sections[indexPath.section];
    TCDoc* doc = chanel.docs[indexPath.row];
    NSLog(@"%@", doc);
    TCDocDetailsViewController* controller = [[TCDocDetailsViewController alloc] initWithNibName:nil bundle:nil];
    controller.detailsUrl = @"http://www.siming.gov.cn:8090/smhdphone/common/jdbcObjectResponse.as?_in=phonewcm@105";
    controller.docId = doc.docId;
    controller.channelId = chanel.channelId;
    controller.docTitle = doc.title;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
