//
//  WKCBlendViewController.m
//  WKCImageEditDemo
//
//  Created by WeiKunChao on 2019/5/17.
//  Copyright © 2019 FaceMoji. All rights reserved.
//

#import "WKCBlendViewController.h"
#import <WKCImageEditView.h>
#import <Masonry.h>
#import "UIColor+Common.h"

@interface WKCBlendViewController ()

@property (nonatomic, strong) WKCImageEditView * editView;
@property (nonatomic, strong) UIButton * middleButton;
@property (nonatomic, strong) UIButton * frontButton;
@property (nonatomic, strong) UIButton * backButton;

@end

@implementation WKCBlendViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    [self.view addSubview:self.editView];
    [self.view addSubview:self.middleButton];
    [self.view addSubview:self.frontButton];
    [self.view addSubview:self.backButton];
    
    [self.editView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.top.equalTo(self.view).offset(20);
        make.height.mas_equalTo(self.view.mas_width);
    }];
    [self.middleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).offset(30);
        make.bottom.equalTo(self.view).offset(-60);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    [self.frontButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.view).offset(-30);
        make.bottom.equalTo(self.view).offset(-60);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-60);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    
    // 约束完再赋值, 或者textView直接坐标添加.  不然内部取不到坐标
    self.editView.contentImage = [UIImage imageNamed:@"bg"];
}


- (void)buttonAction:(UIButton *)sender
{
    if (sender == _middleButton)
    {
        [self.editView blendWithFront:[UIImage imageNamed:@"blend_jiang"] alpha:0.5 blendMode:WKCBlendModeMiddle];
    }
    else if (sender == _frontButton)
    {
        [self.editView blendWithFront:[UIImage imageNamed:@"blend_jiang"] alpha:0.5 blendMode:WKCBlendModeFront];
    }
    else if (sender == _backButton)
    {
        [self.editView blendWithFront:[UIImage imageNamed:@"blend_jiang"] alpha:0.5 blendMode:WKCBlendModeBackground];
    }
    
}




- (WKCImageEditView *)editView
{
    if (!_editView)
    {
        _editView = [[WKCImageEditView alloc] init];
        
    }
    
    return _editView;
}


- (UIButton *)middleButton
{
    if (!_middleButton)
    {
        _middleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_middleButton setTitle:@"前后融合" forState:UIControlStateNormal];
        [_middleButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _middleButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        _middleButton.backgroundColor = [UIColor gradientWithSize:CGSizeMake(100, 50) style:GradientStyleLeftToRight locations:@[@(0.5)] colors:@[@(0x9122fcff), @(0xff71a5ff)]];
        _middleButton.layer.cornerRadius = 12;
        _middleButton.layer.masksToBounds = YES;
        [_middleButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _middleButton;
}

- (UIButton *)frontButton
{
    if (!_frontButton)
    {
        _frontButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_frontButton setTitle:@"突出前景" forState:UIControlStateNormal];
        [_frontButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _frontButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        _frontButton.backgroundColor = [UIColor gradientWithSize:CGSizeMake(100, 50) style:GradientStyleLeftToRight locations:@[@(0.5)] colors:@[@(0x9122fcff), @(0xff71a5ff)]];
        _frontButton.layer.cornerRadius = 12;
        _frontButton.layer.masksToBounds = YES;
        [_frontButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _frontButton;
}

- (UIButton *)backButton
{
    if (!_backButton)
    {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setTitle:@"突出背景" forState:UIControlStateNormal];
        [_backButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _backButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        _backButton.backgroundColor = [UIColor gradientWithSize:CGSizeMake(100, 50) style:GradientStyleLeftToRight locations:@[@(0.5)] colors:@[@(0x9122fcff), @(0xff71a5ff)]];
        _backButton.layer.cornerRadius = 12;
        _backButton.layer.masksToBounds = YES;
        [_backButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _backButton;
}


@end
