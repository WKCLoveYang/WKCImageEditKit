//
//  WKCResizeViewController.m
//  WKCImageEditDemo
//
//  Created by WeiKunChao on 2019/5/15.
//  Copyright © 2019 FaceMoji. All rights reserved.
//

#import "WKCResizeViewController.h"
#import <Masonry.h>
#import "UIColor+Common.h"
#import <WKCImageEditView.h>

@interface WKCResizeViewController ()

@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UIButton * changeButton;

@end

@implementation WKCResizeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Resize";
    
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.changeButton];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.leading.trailing.equalTo(self.view);
        make.height.mas_equalTo(self.view.mas_width);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    [self.changeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-60);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    
}


- (void)buttonAction:(UIButton *)sender
{
    UIImage * image = [UIImage imageNamed:@"bg"];
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    
    self.imageView.image = [image imageScalingToSize:CGSizeMake(width * 0.1, height * 0.1)];
    
    NSInteger currentWidth = self.imageView.image.size.width;
    NSInteger currentHeight = self.imageView.image.size.height;
    _titleLabel.text = [NSString stringWithFormat:@"改后: %ld * %ld", currentWidth, currentHeight];
}

- (UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        
    }
    
    return _imageView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = UIColor.whiteColor;
        _titleLabel.font = [UIFont boldSystemFontOfSize:36];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        UIImage * image = [UIImage imageNamed:@"bg"];
        NSInteger width = image.size.width;
        NSInteger height = image.size.height;
        _titleLabel.text = [NSString stringWithFormat:@"当前: %ld * %ld", width, height];
    }
    
    return _titleLabel;
}


- (UIButton *)changeButton
{
    if (!_changeButton)
    {
        _changeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_changeButton setTitle:@"宽 * 0.1" forState:UIControlStateNormal];
        [_changeButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _changeButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        _changeButton.backgroundColor = [UIColor gradientWithSize:CGSizeMake(100, 50) style:GradientStyleLeftToRight locations:@[@(0.5)] colors:@[@(0x9122fcff), @(0xff71a5ff)]];
        _changeButton.layer.cornerRadius = 12;
        _changeButton.layer.masksToBounds = YES;
        [_changeButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _changeButton;
}

@end
