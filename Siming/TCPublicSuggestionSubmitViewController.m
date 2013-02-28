//
//  TCPublicSuggestionSubmitViewController.m
//  Siming
//
//  Created by mac on 13-2-28.
//  Copyright (c) 2013年 taocore. All rights reserved.
//

#import "TCPublicSuggestionSubmitViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "TCCommon.h"
#import "TBXML.h"

@interface TCPublicSuggestionSubmitViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UISwitch *publicSwitch;
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextView *contentField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation TCPublicSuggestionSubmitViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"信息公开意见箱";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.contentField.layer.borderWidth = 1;
    self.contentField.layer.borderColor = [[UIColor grayColor] CGColor];
    self.contentField.clipsToBounds = YES;
    self.contentField.layer.cornerRadius = 10.0f;
    self.scrollView.contentSize = CGSizeMake(kDeviceWidth, kDeviceHeight - self.navigationController.navigationBar.frame.size.height - self.tabBarController.tabBar.frame.size.height);
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(submit)];
    // Do any additional setup after loading the view from its nib.
}

- (void)submit
{
    NSString* url = @"http://www.siming.gov.cn:8090/smhdphone/common/hbnJsonResponse.as?_in=phoneoption@005";
    NSString* xm = self.nameField.text;
    NSString* email = self.emailField.text;
    NSString* lxdh = self.phoneField.text;
    NSString* zt = self.titleField.text;
    NSString* nr = self.contentField.text;
    BOOL sfgk = self.publicSwitch.on;
    url = [url stringByAppendingFormat:@"&xm=%@&email=%@&lxdh=%@&zt=%@&nr=%@&sfgk=%@", xm, email, lxdh, zt, nr, [NSNumber numberWithBool:sfgk]];
    //NSLog(@"data: %@", [NSString stringWithContentsOfURL:[NSURL URLWithString:url] encoding:NSUTF8StringEncoding error:nil]);
    NSString* xml = [NSString stringWithContentsOfURL:[NSURL URLWithString:url] encoding:NSUTF8StringEncoding error:nil];
    TBXML* tbxml = [TBXML newTBXMLWithXMLString:xml error:nil];
    if (tbxml.rootXMLElement) {
        TBXMLElement* object = [TBXML childElementNamed:@"object" parentElement:tbxml.rootXMLElement];
        if (object)
        {
            NSString* message;
            TBXMLElement* msg = [TBXML childElementNamed:@"msg" parentElement:object];
            if (msg)
            {
                message = [TBXML textForElement:msg];
            }
            else
            {
                TBXMLElement* errorMsg = [TBXML childElementNamed:@"errirMsg" parentElement:object];
                if (errorMsg)
                {
                    message = [TBXML textForElement:errorMsg];
                }
            }
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
        }
    }

}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIScrollView* scrollView = self.scrollView;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIScrollView* scrollView = self.scrollView;
    scrollView.contentInset = UIEdgeInsetsZero;
    scrollView.scrollIndicatorInsets = UIEdgeInsetsZero;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setNameField:nil];
    [self setEmailField:nil];
    [self setPhoneField:nil];
    [self setPublicSwitch:nil];
    [self setTitleField:nil];
    [self setContentField:nil];
    [self setScrollView:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewDidUnload];
}
@end
