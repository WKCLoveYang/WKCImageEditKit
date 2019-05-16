//
//  WKCAdjustmentViewController.m
//  WKCImageEditDemo
//
//  Created by WeiKunChao on 2019/5/15.
//  Copyright © 2019 FaceMoji. All rights reserved.
//

#import "WKCAdjustmentViewController.h"
#import <Masonry.h>
#import <UIImage+Adjustment.h>

@interface WKCAdjustmentViewController ()

@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) UISlider * exposureSlider;
@property (nonatomic, strong) UILabel * exposurelabel;
@property (nonatomic, strong) UISlider * brintnessSlider;
@property (nonatomic, strong) UILabel * brintnesslabel;
@property (nonatomic, strong) UISlider * contrastSlider;
@property (nonatomic, strong) UILabel * contrastlabel;
@property (nonatomic, strong) UISlider * saturationSlider;
@property (nonatomic, strong) UILabel * saturationlabel;
@property (nonatomic, strong) UISlider * sharpenSlider;
@property (nonatomic, strong) UILabel * sharpenlabel;


@end

@implementation WKCAdjustmentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
     self.navigationItem.title = @"Adjustment";
    
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.exposureSlider];
    [self.view addSubview:self.exposurelabel];
    [self.view addSubview:self.brintnessSlider];
    [self.view addSubview:self.brintnesslabel];
    [self.view addSubview:self.contrastSlider];
    [self.view addSubview:self.contrastlabel];
    [self.view addSubview:self.saturationSlider];
    [self.view addSubview:self.saturationlabel];
    [self.view addSubview:self.sharpenSlider];
    [self.view addSubview:self.sharpenlabel];
    
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-50);
        make.leading.trailing.equalTo(self.view);
        make.height.mas_equalTo(self.view.mas_width);
    }];
    [self.exposureSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.equalTo(self.view).offset(20);
        make.size.mas_equalTo(CGSizeMake(200, 30));
    }];
    [self.exposurelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.exposureSlider);
        make.leading.equalTo(self.exposureSlider.mas_trailing).offset(15);
    }];
    [self.brintnessSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.exposureSlider);
        make.size.mas_equalTo(CGSizeMake(200, 30));
        make.top.equalTo(self.exposureSlider.mas_bottom).offset(5);
    }];
    [self.brintnesslabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.brintnessSlider);
        make.leading.equalTo(self.brintnessSlider.mas_trailing).offset(15);
    }];
    [self.contrastSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.exposureSlider);
        make.size.mas_equalTo(CGSizeMake(200, 30));
        make.top.equalTo(self.brintnessSlider.mas_bottom).offset(5);
    }];
    [self.contrastlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contrastSlider);
        make.leading.equalTo(self.contrastSlider.mas_trailing).offset(15);
    }];
    [self.saturationSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.exposureSlider);
        make.size.mas_equalTo(CGSizeMake(200, 30));
        make.top.equalTo(self.contrastSlider.mas_bottom).offset(5);
    }];
    [self.saturationlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.saturationSlider);
        make.leading.equalTo(self.saturationSlider.mas_trailing).offset(15);
    }];
    [self.sharpenSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.saturationSlider);
        make.size.mas_equalTo(CGSizeMake(200, 30));
        make.top.equalTo(self.saturationSlider.mas_bottom).offset(5);
    }];
    [self.sharpenlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.sharpenSlider);
        make.leading.equalTo(self.sharpenSlider.mas_trailing).offset(15);
    }];
    
}


- (void)sliderValueChanged:(UISlider *)sender
{
    if (sender == _exposureSlider)
    {
        _exposurelabel.text = [NSString stringWithFormat:@"%.1f", sender.value];
        self.imageView.image = [[UIImage imageNamed:@"bg"] exposureWithValue:sender.value];
    }
    else if (sender == _brintnessSlider)
    {
        _brintnesslabel.text = [NSString stringWithFormat:@"%.1f", sender.value];;
        self.imageView.image = [[UIImage imageNamed:@"bg"] brightnessWithValue:sender.value];
    }
    else if (sender == _contrastSlider)
    {
        _contrastlabel.text = [NSString stringWithFormat:@"%.1f", sender.value];;
        self.imageView.image = [[UIImage imageNamed:@"bg"] contrastWithValue:sender.value];
    }
    else if (sender == _saturationSlider)
    {
        _saturationlabel.text = [NSString stringWithFormat:@"%.1f", sender.value];;
        self.imageView.image = [[UIImage imageNamed:@"bg"] saturationWithValue:sender.value];
    }
    else if (sender == _sharpenSlider)
    {
        _sharpenlabel.text = [NSString stringWithFormat:@"%.1f", sender.value];;
       self.imageView.image = [[UIImage imageNamed:@"bg"] highlightShadowWithValue:sender.value];
    }
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

- (UISlider *)exposureSlider
{
    if (!_exposureSlider)
    {
        _exposureSlider = [[UISlider alloc] init];
        _exposureSlider.minimumValue = -1;
        _exposureSlider.maximumValue = 1;
        _exposureSlider.value = 0;
        [_exposureSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    
    return _exposureSlider;
}

- (UILabel *)exposurelabel
{
    if (!_exposurelabel)
    {
        _exposurelabel = [[UILabel alloc] init];
        _exposurelabel.font = [UIFont boldSystemFontOfSize:24];
        _exposurelabel.textColor = [UIColor blackColor];
    }
    
    return _exposurelabel;
}

- (UISlider *)brintnessSlider
{
    if (!_brintnessSlider)
    {
        _brintnessSlider = [[UISlider alloc] init];
        _brintnessSlider.minimumValue = -1;
        _brintnessSlider.maximumValue = 1;
        _brintnessSlider.value = 0;
        [_brintnessSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    
    return _brintnessSlider;
}

- (UILabel *)brintnesslabel
{
    if (!_brintnesslabel)
    {
        _brintnesslabel = [[UILabel alloc] init];
        _brintnesslabel.font = [UIFont boldSystemFontOfSize:24];
        _brintnesslabel.textColor = [UIColor blackColor];
    }
    
    return _brintnesslabel;
}

- (UISlider *)contrastSlider
{
    if (!_contrastSlider)
    {
        _contrastSlider = [[UISlider alloc] init];
        _contrastSlider.minimumValue = 0;
        _contrastSlider.maximumValue = 4;
        _contrastSlider.value = 1;
        [_contrastSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    
    return _contrastSlider;
}

- (UILabel *)contrastlabel
{
    if (!_contrastlabel)
    {
        _contrastlabel = [[UILabel alloc] init];
        _contrastlabel.font = [UIFont boldSystemFontOfSize:24];
        _contrastlabel.textColor = [UIColor blackColor];
    }
    
    return _contrastlabel;
}

- (UISlider *)saturationSlider
{
    if (!_saturationSlider)
    {
        _saturationSlider = [[UISlider alloc] init];
        _saturationSlider.minimumValue = -3.14;
        _saturationSlider.maximumValue = 3.14;
        _saturationSlider.value = 0;
        [_saturationSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    
    return _saturationSlider;
}

- (UILabel *)saturationlabel
{
    if (!_saturationlabel)
    {
        _saturationlabel = [[UILabel alloc] init];
        _saturationlabel.font = [UIFont boldSystemFontOfSize:24];
        _saturationlabel.textColor = [UIColor blackColor];
    }
    
    return _saturationlabel;
}

- (UISlider *)sharpenSlider
{
    if (!_sharpenSlider)
    {
        _sharpenSlider = [[UISlider alloc] init];
        _sharpenSlider.minimumValue = 0.3;
        _sharpenSlider.maximumValue = 1;
        _sharpenSlider.value = 1;
        [_sharpenSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    
    return _sharpenSlider;
}

- (UILabel *)sharpenlabel
{
    if (!_sharpenlabel)
    {
        _sharpenlabel = [[UILabel alloc] init];
        _sharpenlabel.font = [UIFont boldSystemFontOfSize:24];
        _sharpenlabel.textColor = [UIColor blackColor];
    }
    
    return _sharpenlabel;
}

@end
