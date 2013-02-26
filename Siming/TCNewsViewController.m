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

@interface TCNewsViewController ()

@property (strong, nonatomic) UIScrollView* scrollView;
@property (strong, nonatomic) UITableView* tableView;
@property (strong, nonatomic) UIPageControl* pageControl;
@property (nonatomic) NSString* currentElement;
@property (nonatomic) TCDoc* currentDoc;
@property (strong, nonatomic) NSMutableArray* docs;

@end

@implementation TCNewsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"新闻公告";
        self.tabBarItem.image = [UIImage imageNamed:@"fjyw"];
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
    [self.view addSubview:scrollView];
    for (int i = 0; i < 5; i++)
    {
        CGRect frame = scrollView.frame;
        frame.origin = CGPointMake(pageWidth * i, 0);
        TCImagePage *view = [[TCImagePage alloc] initWithFrame:frame];
        //view.tag = i + 1;
        [scrollView addSubview:view];
    }
    self.scrollView = scrollView;
    
    UIView* pageControlView = [[UIView alloc] initWithFrame:CGRectMake(0, 160, kDeviceWidth, 20)];
    pageControlView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:pageControlView];
    UIPageControl* pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 20)];
    pageControl.numberOfPages = pageNumber;
    pageControl.userInteractionEnabled = NO;
    [pageControlView addSubview:pageControl];
    self.pageControl = pageControl;
        
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 180, 320, kMainViewHeight - 180) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    [self loadData];
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"正在加载新闻，请稍候...";
}

- (void)loadData
{
    NSURL* url = [[NSURL alloc] initWithString:@"http://www.siming.gov.cn:8090/smhdphone/common/jdbcNoPageResponse.as?_in=phonewcm@101&pageSize=5&channelId=2345"];
    __block TCNewsViewController* weakSelf = self;
    [TBXML newTBXMLWithURL:url
                   success:^(TBXML *tbxml){
                       weakSelf.docs = [NSMutableArray array];
                       if (tbxml.rootXMLElement) {
                           TBXMLElement* object = [TBXML childElementNamed:@"object" parentElement:tbxml.rootXMLElement];
                           if (object)
                           {
                               TCDoc* doc = [TCDoc docWithElement:object];
                               [weakSelf.docs addObject:doc];
                               while ((object = [TBXML nextSiblingNamed:@"object" searchFromElement:object]))
                               {
                                   TCDoc* doc = [TCDoc docWithElement:object];
                                   [weakSelf.docs addObject:doc];
                               }
                           }
                       }
                       NSLog(@"docs: %@", weakSelf.docs);
                       int i = 0;
                       for (TCDoc* doc in weakSelf.docs)
                       {
                           TCImagePage* imageView = self.scrollView.subviews[i++];
                           imageView.title = doc.title;
                           NSString* docUrl = doc.docPubUrl;
                           NSString* baseUrl = [docUrl stringByDeletingLastPathComponent];
                           NSString* imageUrl = [baseUrl stringByAppendingPathComponent:doc.imagePath];
                           imageView.imageUrl = imageUrl;
                       }
                       [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
                   }
                   failure:^(TBXML* tbxml, NSError* error){
                       
                   }];
    url = [NSURL URLWithString:@"http://www.siming.gov.cn:8090/smhdphone/common/jdbcObjectResponse.as?_in=phonewcm@105&id=10461662&channelId=2340"];
    //NSData* data = [[NSData alloc] initWithContentsOfURL:url];
    NSLog(@"data: %@", [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil]);
    /*[TBXML newTBXMLWithURL:url
                   success:^(TBXML *tbxml){
                       NSLog(@"xml: %@", tbxml);
                   }
                   failure:^(TBXML* tbxml, NSError* error){
                       NSLog(@"error: %@", error);
                   }];*/
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
