//
//  TCDocDetailsViewController.m
//  Siming
//
//  Created by mac on 13-2-26.
//  Copyright (c) 2013年 taocore. All rights reserved.
//

#import "TCDocDetailsViewController.h"
#import "TBXML.h"
#import "TBXML+HTTP.h"
#import "TBXML+Compression.h"
#import "MBProgressHUD.h"
#import "TCDoc.h"
#import "TCCommon.h"

@interface TCDocDetailsViewController ()

@property (strong, nonatomic) UIWebView* contentView;

@end

@implementation TCDocDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"详细信息";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.contentView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kMainViewHeight - self.navigationController.navigationBar.frame.size.height - self.tabBarController.tabBar.frame.size.height)];
    self.contentView.dataDetectorTypes = UIDataDetectorTypePhoneNumber;
    //self.contentView.keyboardDisplayRequiresUserAction = YES;
    [self.view addSubview:self.contentView];
    [self loadData];
}

- (void)loadData
{
    NSString* url = @"http://www.siming.gov.cn:8090/smhdphone/common/jdbcObjectResponse.as?_in=phonewcm@106";
    url = [url stringByAppendingFormat:@"&channelId=%@&id=%@", self.channelId, self.docId];
    NSLog(@"url: %@", url);
    //NSLog(@"data: %@", [NSString stringWithContentsOfURL:[NSURL URLWithString:url] encoding:NSUTF8StringEncoding error:nil]);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __block TCDocDetailsViewController* weakSelf = self;
    [TBXML newTBXMLWithURL:[NSURL URLWithString:url]
                   success:^(TBXML *tbxml){
                       if (tbxml.rootXMLElement) {
                           TBXMLElement* object = [TBXML childElementNamed:@"object" parentElement:tbxml.rootXMLElement];
                           if (object)
                           {
                               TCDoc* doc = [TCDoc docWithElement:object];
                               NSLog(@"1111");
                               NSString* html = [self contentTemplate];
                               NSLog(@"222");
                               html = [NSString stringWithFormat:html, self.docTitle, doc.createDate, doc.content];
                               NSLog(@"333");
                               [self.contentView loadHTMLString:html baseURL:nil];
                               NSLog(@"444");
                           }
                       }
                       NSLog(@"555");
                       [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
                   }
                   failure:^(TBXML* tbxml, NSError* error){
                       NSLog(@"error: %@", error);
                   }];
}

- (NSString*)contentTemplate
{
    return @"<html><h4 style=\"text-align:center;margin-bottom:0;\">%@</h4><div style=\"text-align:center;margin-bottom:15px;\">发布时间：%@</div><hr/><article>%@</article></html>";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
