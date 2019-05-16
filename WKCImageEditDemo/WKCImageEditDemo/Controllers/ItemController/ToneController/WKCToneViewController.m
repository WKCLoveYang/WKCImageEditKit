//
//  WKCToneViewController.m
//  WKCImageEditDemo
//
//  Created by WeiKunChao on 2019/5/15.
//  Copyright © 2019 FaceMoji. All rights reserved.
//

#import "WKCToneViewController.h"
#import <Masonry.h>
#import <WKCToneCurveView.h>

@interface WKCToneViewController ()
<WKCToneCurveViewDelegate>

@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) WKCToneCurveView * toneView;

@end

@implementation WKCToneViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"ToneCurve";
    
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.toneView];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.leading.trailing.equalTo(self.view);
        make.height.mas_equalTo(self.view.mas_width);
    }];
}

#pragma mark -WKCToneCurveViewDelegate
- (UIImage *)toneCurveViewOriginImage:(WKCToneCurveView *)toneCurveView
{
    return [UIImage imageNamed:@"bg"];
}

- (void)toneCurveView:(WKCToneCurveView *)toneCurveView didtoneCurved:(UIImage *)newImage
{
    self.imageView.image = newImage;
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

- (WKCToneCurveView *)toneView
{
    if (!_toneView)
    {
        _toneView = [[WKCToneCurveView alloc] initWithFrame:CGRectMake(20, 20, 200, 200) pointSize:CGSizeMake(10, 10)];
        _toneView.delegate = self;
        _toneView.gridColor = UIColor.blackColor;
        _toneView.pointColor = UIColor.blackColor;
        _toneView.lineColor = UIColor.blackColor;
    }
    
    return _toneView;
}

@end
