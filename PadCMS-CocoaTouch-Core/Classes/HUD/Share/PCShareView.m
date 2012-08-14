//
//  RRShareView.m
//  PadCMS-CocoaTouch-Core
//
//  Created by Maxim Pervushin on 8/14/12.
//  Copyright (c) 2012 Adyax. All rights reserved.
//

#import "PCShareView.h"

#import "PCLocalizationManager.h"

@interface PCShareView ()

- (void)shareFacebookButtonAction:(UIButton *)button;
- (void)shareTwitterButtonAction:(UIButton *)button;
- (void)shareMailButtonAction:(UIButton *)button;

@end

@implementation PCShareView
@synthesize delegate;
@synthesize presented = _presented;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self != nil) {
        _presented = NO;
    }
    return self;
}

- (void)shareFacebookButtonAction:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(shareViewFacebookShare:)]) {
        [self.delegate shareViewFacebookShare:self];
    }
    
    [self dismiss];
}

- (void)shareTwitterButtonAction:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(shareViewTwitterShare:)]) {
        [self.delegate shareViewTwitterShare:self];
    }
    
    [self dismiss];
}

- (void)shareMailButtonAction:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(shareViewMailShare:)]) {
        [self.delegate shareViewMailShare:self];
    }

    [self dismiss];
}

#pragma mark - public class methods

+ (PCShareView *)configuredShareView
{
    UIImage *backgroundImage = [UIImage imageNamed:@"sharePopup.png"];
    CGSize imageSize = backgroundImage.size;
    PCShareView *shareView = [[PCShareView alloc] initWithFrame:CGRectMake(0, 0, imageSize.width, imageSize.height)];
    
    // configure share view
    
    UIImageView *backgroundImageView = [[[UIImageView alloc] initWithImage:backgroundImage] autorelease];
    [shareView addSubview:backgroundImageView];
    
    UILabel *titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 30, imageSize.width, 20)] autorelease];
    titleLabel.text = [PCLocalizationManager localizedStringForKey:@"SHARING_MENU_CAPTION"
                                                             value:@"SHARING"];
    
    titleLabel.font = [UIFont fontWithName:@"Helvetica" size:17];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = UITextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor clearColor];
    [shareView addSubview:titleLabel];
    
    // Facebook
    UIButton *facebookButton = [UIButton buttonWithType:UIButtonTypeCustom];
    facebookButton.frame = CGRectMake(0, 0, 153, 45);
    facebookButton.center = CGPointMake(85, 76);
    [facebookButton addTarget:shareView
                    action:@selector(shareFacebookButtonAction:)
          forControlEvents:UIControlEventTouchUpInside];
    [facebookButton setImage:[UIImage imageNamed:@"btnFacebook.png"]
                 forState:UIControlStateNormal];
    [shareView addSubview:facebookButton];
    
    UILabel *facebookTitle = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 45)] autorelease];
    facebookTitle.font = [UIFont fontWithName:@"Arial" size:13];
    facebookTitle.textColor = [UIColor whiteColor];
    facebookTitle.backgroundColor = [UIColor blackColor];
    facebookTitle.center = CGPointMake(95, 76);
    facebookTitle.text = @"Facebook";
    [shareView addSubview:facebookTitle];

    // Twitter
    UIButton *twitterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    twitterButton.frame = CGRectMake(0, 0, 153, 45);
    twitterButton.center = CGPointMake(85, facebookButton.center.y + 45);
    [twitterButton addTarget:shareView
                      action:@selector(shareTwitterButtonAction:)
            forControlEvents:UIControlEventTouchUpInside];
    [twitterButton setImage:[UIImage imageNamed:@"btnTwitter.png"] forState:UIControlStateNormal];
    [shareView addSubview:twitterButton];
    
    UILabel *twitterTitle = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 45)] autorelease];
    twitterTitle.font = [UIFont fontWithName:@"Arial" size:13];
    twitterTitle.textColor = [UIColor whiteColor];
    twitterTitle.backgroundColor = [UIColor blackColor];
    twitterTitle.center = CGPointMake(95, facebookButton.center.y + 45);
    twitterTitle.text = @"Twitter";
    [shareView addSubview:twitterTitle];

    // Email
    UIButton *emailButton = [UIButton buttonWithType:UIButtonTypeCustom];
    emailButton.frame = CGRectMake(0, 0, 153, 45);
    emailButton.center = CGPointMake(85, twitterButton.center.y + 45);
    [emailButton addTarget:shareView
                    action:@selector(shareMailButtonAction:)
          forControlEvents:UIControlEventTouchUpInside];
    [emailButton setImage:[UIImage imageNamed:@"btnEmail.png"] forState:UIControlStateNormal];
    [shareView addSubview:emailButton];
    
    UILabel *emailTitle = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 102, 45)] autorelease];
    emailTitle.font = [UIFont fontWithName:@"Arial" size:13];
    emailTitle.textColor = [UIColor whiteColor];
    emailTitle.backgroundColor = [UIColor blackColor];
    emailTitle.center = CGPointMake(95 + 11, twitterButton.center.y + 45);
    emailTitle.text = [PCLocalizationManager localizedStringForKey:@"SHARING_MENU_TITLE_EMAIL"
                                                             value:@"Send Email"];
    [shareView addSubview:emailTitle];

    
    return [shareView autorelease];
}

#pragma mark - public class methods

- (void)presentInView:(UIView *)view atPoint:(CGPoint)point
{
    if (view == nil) {
        return;
    }
    
    CGSize selfSize = self.bounds.size;
    
    CGFloat xOffset = -selfSize.width + 55;
    CGFloat yOffset = 20;
    
    self.frame = CGRectMake(point.x + xOffset, point.y + yOffset, selfSize.width, selfSize.height);
    [view addSubview:self];
    _presented = YES;
}

- (void)dismiss
{
    if (self.superview != nil) {
        [self removeFromSuperview];
        _presented = NO;
    }
}

@end
