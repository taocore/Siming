//
//  TCImagePage.m
//  Siming
//
//  Created by taocore on 13-2-24.
//  Copyright (c) 2013年 taocore. All rights reserved.
//

#import "TCImagePage.h"
#import "UIImageView+WebCache.h"
#import "TCCommon.h"

@interface TCImagePage ()

@property (strong, nonatomic) UIImageView* imageView;
@property (strong, nonatomic) UILabel* label;

@end

@implementation TCImagePage

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"picnews"]];
        imageView.frame = frame;
        [self addSubview:imageView];
        self.imageView = imageView;
        CGRect labelFrame = CGRectMake(0, frame.size.height - 30, kDeviceWidth, 30);
        UILabel* label = [[UILabel alloc] initWithFrame:labelFrame];
        label.backgroundColor = [[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:0.3];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14];
        [self addSubview:label];
        self.label = label;
    }
    return self;
}

- (void)setImageUrl:(NSString *)imageUrl
{
    [self.imageView setImageWithURL:[NSURL URLWithString:imageUrl]];
}

- (void)setTitle:(NSString *)title
{
    self.label.text = title;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
