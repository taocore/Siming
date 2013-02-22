//
//  TCFirstViewController.m
//  Siming
//
//  Created by mac on 13-2-1.
//  Copyright (c) 2013年 taocore. All rights reserved.
//

#import "TCNewsViewController.h"
#import "TCCommon.h"

@interface TCNewsViewController ()

@property (strong, nonatomic) UITableView* tableView;
@property (strong, nonatomic) UIPageControl* pageControl;

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
    [self.view addSubview:scrollView];
    UIImageView *view1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"welcome1"]];
    UIImageView *view2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"welcome2"]];
    UIImageView *view3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"welcome3"]];
    //CGRect frame1 = view1.frame;
    view1.frame = scrollView.frame;
    view2.frame = scrollView.frame;
    view3.frame = scrollView.frame;
    CGRect frame2 = view2.frame;
    frame2.origin = CGPointMake(scrollView.frame.size.width, 0);
    view2.frame = frame2;
    CGRect frame3 = view3.frame;
    frame3.origin = CGPointMake(scrollView.frame.size.width * 2, 0);
    view3.frame = frame3;
    [scrollView addSubview:view1];
    [scrollView addSubview:view2];
    [scrollView addSubview:view3];
    
    UIView* pageControlView = [[UIView alloc] initWithFrame:CGRectMake(0, 160, kDeviceWidth, 20)];
    [self.view addSubview:pageControlView];
    UIPageControl* pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 20)];
    pageControl.numberOfPages = pageNumber;
    pageControl.userInteractionEnabled = NO;
    [pageControlView addSubview:pageControl];
    self.pageControl = pageControl;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 180, 320, kMainViewHeight - 180) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
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
