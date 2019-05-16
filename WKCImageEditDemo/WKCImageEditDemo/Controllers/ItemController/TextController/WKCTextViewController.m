//
//  WKCTextViewController.m
//  WKCImageEditDemo
//
//  Created by WeiKunChao on 2019/5/15.
//  Copyright © 2019 FaceMoji. All rights reserved.
//

#import "WKCTextViewController.h"
#import <WKCImageEditView.h>
#import <Masonry.h>
#import "UIColor+Common.h"

@interface WKCTextViewController ()
<WKCImageEditViewTextDelegate>

@property (nonatomic, strong) WKCImageEditView * textView;
@property (nonatomic, strong) UIButton * addButton;
@property (nonatomic, strong) UIButton * saveButton;
@property (nonatomic, strong) UIImageView * presentImageView;

@end

@implementation WKCTextViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Text";
    
    [self.view addSubview:self.textView];
    [self.view addSubview:self.addButton];
    [self.view addSubview:self.saveButton];
    [self.view addSubview:self.presentImageView];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
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
    self.textView.contentImage = [UIImage imageNamed:@"bg"];
}


- (void)buttonAction:(UIButton *)sender
{
    if (sender == _addButton)
    {
        NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:@"这是一个测试" attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:18], NSForegroundColorAttributeName: UIColor.blueColor}];
        self.textView.textString = string;
    }
    else if (sender == _saveButton)
    {
        self.presentImageView.image = self.textView.currentImage;
    }
}

#pragma mark -WKCImageEditViewTextDelegate
- (void)textDidReachLimit:(WKCImageEditView *)imageEdit
{
    NSLog(@"最多添加%ld个", imageEdit.textLimitCount);
}


- (WKCImageEditView *)textView
{
    if (!_textView)
    {
        _textView = [[WKCImageEditView alloc] init];
        _textView.textRorationImage = [UIImage imageNamed:@"roration"];
        _textView.textDeleteImage = [UIImage imageNamed:@"delete"];
        _textView.textDelegate = self;
    }
    
    return _textView;
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
