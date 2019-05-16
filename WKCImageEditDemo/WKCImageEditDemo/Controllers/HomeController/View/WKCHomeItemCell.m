//
//  WKCHomeItemCell.m
//  WKCImageEditDemo
//
//  Created by WeiKunChao on 2019/5/15.
//  Copyright © 2019 FaceMoji. All rights reserved.
//

#import "WKCHomeItemCell.h"
#import "UIView+SLCShadow.h"
#import <Masonry.h>

@interface WKCHomeItemCell()

@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) UILabel * titleLabel;

@end

@implementation WKCHomeItemCell

+ (CGSize)itemSize
{
    return CGSizeMake(UIScreen.mainScreen.bounds.size.width - 30, 150);
}

- (void)setImageStr:(NSString *)imageStr
{
    _imageStr = imageStr;
    self.imageView.image = [UIImage imageNamed:imageStr];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.layer.masksToBounds = NO;
        self.contentView.backgroundColor = UIColor.whiteColor;
        self.contentView.shadow = SLCShadowMake(CGSizeMake(0, 12), 20, 0.3, 0x999999, 8);
        
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.titleLabel];
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.leading.equalTo(self.contentView).offset(15);
            make.size.mas_equalTo(CGSizeMake(130, 130));
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.leading.equalTo(self.imageView.mas_trailing).offset(20);
        }];
    }
    
    return self;
}

#pragma mark -Property
- (UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.layer.masksToBounds = YES;
    }
    
    return _imageView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = UIColor.blackColor;
    }
    
    return _titleLabel;
}

@end
