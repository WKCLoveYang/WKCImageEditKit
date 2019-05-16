//
//  WKCStickerViewController.m
//  WKCImageEditDemo
//
//  Created by WeiKunChao on 2019/5/15.
//  Copyright © 2019 FaceMoji. All rights reserved.
//

#import "WKCStickerViewController.h"
#import <Masonry.h>
#import "UIColor+Common.h"
#import <WKCImageEditView.h>

@interface WKCStickerViewController ()
<WKCImageEditViewStickerDelegate>

@property (nonatomic, strong) WKCImageEditView * stickerView;
@property (nonatomic, strong) UIButton * addButton;
@property (nonatomic, strong) UIButton * saveButton;
@property (nonatomic, strong) UIImageView * presentImageView;

@end

@implementation WKCStickerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    self.navigationItem.title = @"Sticker";
    
    [self.view addSubview:self.stickerView];
    [self.view addSubview:self.addButton];
    [self.view addSubview:self.saveButton];
    [self.view addSubview:self.presentImageView];
    
    [self.stickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.top.equalTo(self.view).offset(20);
        make.height.mas_equalTo(UIScreen.mainScreen.bounds.size.width);
    }];
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).offset(20);
        make.bottom.equalTo(self.view).offset(-30);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.view).offset(-20);
        make.bottom.equalTo(self.view).offset(-30);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    [self.presentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.saveButton.mas_top).offset(-10);
        make.size.mas_equalTo(CGSizeMake(250, 250));
    }];
    
    // 约束完再赋值, 或者textView直接坐标添加.  不然内部取不到坐标
    _stickerView.contentImage = [UIImage imageNamed:@"bg"];
}


- (void)buttonAction:(UIButton *)sender
{
    if (sender == _addButton)
    {
        self.stickerView.stickerImage = [UIImage imageNamed:@"sticker"];
    }
    else if (sender == _saveButton)
    {
        self.presentImageView.image = self.stickerView.currentImage;
    }
}

- (void)stickerDidReachLimit:(WKCImageEditView *)imageEdit
{
    NSLog(@"最多添加%ld个", imageEdit.stickerLimitCount);
}



- (WKCImageEditView *)stickerView
{
    if (!_stickerView)
    {
        _stickerView = [[WKCImageEditView alloc] init];
        _stickerView.stickerRorationImage = [UIImage imageNamed:@"roration"];;
        _stickerView.stickerDeleteImage = [UIImage imageNamed:@"delete"];
        _stickerView.stickerDelegate = self;
    }
    
    return _stickerView;
}

- (UIButton *)addButton
{
    if (!_addButton)
    {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton setTitle:@"增加一个" forState:UIControlStateNormal];
        [_addButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _addButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        _addButton.backgroundColor = [UIColor gradientWithSize:CGSizeMake(100, 50) style:GradientStyleLeftToRight locations:@[@(0.5)] colors:@[@(0x9122fcff), @(0xff71a5ff)]];
        _addButton.layer.cornerRadius = 12;
        _addButton.layer.masksToBounds = YES;
        [_addButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _addButton;
}

- (UIButton *)saveButton
{
    if (!_saveButton)
    {
        _saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveButton setTitle:@"保存图" forState:UIControlStateNormal];
        [_saveButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _saveButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        _saveButton.backgroundColor = [UIColor gradientWithSize:CGSizeMake(100, 50) style:GradientStyleLeftToRight locations:@[@(0.5)] colors:@[@(0x9122fcff), @(0xff71a5ff)]];
        _saveButton.layer.cornerRadius = 12;
        _saveButton.layer.masksToBounds = YES;
        [_saveButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _saveButton;
}

- (UIImageView *)presentImageView
{
    if (!_presentImageView)
    {
        _presentImageView = [[UIImageView alloc] init];
        _presentImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    return _presentImageView;
}

@end
