//
//  WKCDrawViewController.m
//  WKCImageEditDemo
//
//  Created by WeiKunChao on 2019/5/15.
//  Copyright © 2019 FaceMoji. All rights reserved.
//

#import "WKCDrawViewController.h"
#import <Masonry.h>
#import <WKCImageEditView.h>
#import "UIColor+Common.h"

@interface WKCDrawViewController ()

@property (nonatomic, strong) WKCImageEditView * drawView;
@property (nonatomic, strong) UIButton * clearButton;
@property (nonatomic, strong) UIButton * revokeButton;
@property (nonatomic, strong) UIButton * earseButton;


@end

@implementation WKCDrawViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Draw";
    
    [self.view addSubview:self.drawView];
    [self.view addSubview:self.clearButton];
    [self.view addSubview:self.revokeButton];
    [self.view addSubview:self.earseButton];

    [self.drawView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.top.equalTo(self.view).offset(20);
        make.height.mas_equalTo(UIScreen.mainScreen.bounds.size.width);
    }];
    [self.clearButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).offset(30);
        make.bottom.equalTo(self.view).offset(-60);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    [self.revokeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.view).offset(-30);
        make.bottom.equalTo(self.view).offset(-60);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    [self.earseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-60);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];

    // 约束完再赋值, 或者textView直接坐标添加.  不然内部取不到坐标
    _drawView.contentImage = [UIImage imageNamed:@"bg"];
    _drawView.drawCouldUse = YES;
}


- (void)buttonAction:(UIButton *)sender
{
    if (sender == _clearButton)
    {
        [self.drawView drawClear];
    }
    else if (sender == _revokeButton)
    {
        [self.drawView drawRevoke];
    }
    else if (sender == _earseButton)
    {
        [self.drawView drawErase];
    }

}



- (WKCImageEditView *)drawView
{
    if (!_drawView)
    {
        _drawView = [[WKCImageEditView alloc] init];
    }
    
    return _drawView;
}

- (UIButton *)clearButton
{
    if (!_clearButton)
    {
        _clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_clearButton setTitle:@"清除" forState:UIControlStateNormal];
        [_clearButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _clearButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        _clearButton.backgroundColor = [UIColor gradientWithSize:CGSizeMake(100, 50) style:GradientStyleLeftToRight locations:@[@(0.5)] colors:@[@(0x9122fcff), @(0xff71a5ff)]];
        _clearButton.layer.cornerRadius = 12;
        _clearButton.layer.masksToBounds = YES;
        [_clearButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _clearButton;
}

- (UIButton *)revokeButton
{
    if (!_revokeButton)
    {
        _revokeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_revokeButton setTitle:@"撤销" forState:UIControlStateNormal];
        [_revokeButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _revokeButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        _revokeButton.backgroundColor = [UIColor gradientWithSize:CGSizeMake(100, 50) style:GradientStyleLeftToRight locations:@[@(0.5)] colors:@[@(0x9122fcff), @(0xff71a5ff)]];
        _revokeButton.layer.cornerRadius = 12;
        _revokeButton.layer.masksToBounds = YES;
        [_revokeButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _revokeButton;
}

- (UIButton *)earseButton
{
    if (!_earseButton)
    {
        _earseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_earseButton setTitle:@"橡皮" forState:UIControlStateNormal];
        [_earseButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _earseButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        _earseButton.backgroundColor = [UIColor gradientWithSize:CGSizeMake(100, 50) style:GradientStyleLeftToRight locations:@[@(0.5)] colors:@[@(0x9122fcff), @(0xff71a5ff)]];
        _earseButton.layer.cornerRadius = 12;
        _earseButton.layer.masksToBounds = YES;
        [_earseButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _earseButton;
}


@end
