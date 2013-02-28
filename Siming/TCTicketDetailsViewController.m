//
//  TCTicketDetailsViewController.m
//  Siming
//
//  Created by mac on 13-2-28.
//  Copyright (c) 2013年 taocore. All rights reserved.
//

#import "TCTicketDetailsViewController.h"
#import "TCCommon.h"
#import "MBProgressHUD.h"
#import "TBXML+HTTP.h"
#import "TCTicket.h"

@interface TCTicketDetailsViewController ()

@property (strong, nonatomic) UIWebView* contentView;

@end

@implementation TCTicketDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"详细信息";
        _detailsUrl = @"http://www.siming.gov.cn:8090/smhdphone/common/jdbcObjectResponse.as?_in=phonequestion@003";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.contentView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kMainViewHeight - self.navigationController.navigationBar.frame.size.height - self.tabBarController.tabBar.frame.size.height)];
    self.contentView.dataDetectorTypes = UIDataDetectorTypePhoneNumber;
    [self.view addSubview:self.contentView];
    [self loadData];
}

- (void)loadData
{
    NSString* url = [self.detailsUrl stringByAppendingFormat:@"&id=%@", self.ticketId];
    NSLog(@"url: %@", url);
    //NSLog(@"data: %@", [NSString stringWithContentsOfURL:[NSURL URLWithString:url] encoding:NSUTF8StringEncoding error:nil]);
    //[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //__block TCTicketDetailsViewController* weakSelf = self;
    [TBXML newTBXMLWithURL:[NSURL URLWithString:url]
                   success:^(TBXML *tbxml){
                       if (tbxml.rootXMLElement) {
                           TBXMLElement* object = [TBXML childElementNamed:@"object" parentElement:tbxml.rootXMLElement];
                           if (object)
                           {
                               TCTicket* ticket = [TCTicket ticketWithElement:object];
                               NSString* templatePath = [[NSBundle mainBundle] pathForResource:@"ticket" ofType:@"tpl"];
                               NSString* html = [NSString stringWithContentsOfFile:templatePath encoding:NSUTF8StringEncoding error:nil];
                               html = [NSString stringWithFormat:html, ticket.title, ticket.createDate, ticket.content, ticket.department, ticket.accessDate, ticket.reply];
                               [self.contentView loadHTMLString:html baseURL:nil];
                           }
                       }
                       NSLog(@"555");
                       //[MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
                   }
                   failure:^(TBXML* tbxml, NSError* error){
                       NSLog(@"error: %@", error);
                   }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
