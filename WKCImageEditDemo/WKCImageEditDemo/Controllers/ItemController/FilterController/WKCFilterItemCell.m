//
//  WKCFilterItemCell.m
//  WKCImageEditDemo
//
//  Created by WeiKunChao on 2019/5/16.
//  Copyright © 2019 FaceMoji. All rights reserved.
//

#import "WKCFilterItemCell.h"
#import <Masonry.h>

@interface WKCFilterItemCell()

@property (nonatomic, strong) UILabel * titlelLabel;

@end

@implementation WKCFilterItemCell

+ (CGSize)itemSize
{
    return CGSizeMake(80, 100);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.contentView.layer.cornerRadius = 8;
        self.contentView.layer.masksToBounds = YES;
        self.contentView.backgroundColor = UIColor.yellowColor;
        
        [self.contentView addSubview:self.titlelLabel];
        
        [self.titlelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    self.titlelLabel.text = title;
}

- (UILabel *)titlelLabel
{
    if (!_titlelLabel)
    {
        _titlelLabel = [[UILabel alloc] init];
        _titlelLabel.textAlignment = NSTextAlignmentCenter;
        _titlelLabel.textColor = UIColor.blackColor;
        _titlelLabel.font = [UIFont boldSystemFontOfSize:20];
    }
    
    return _titlelLabel;
}

@end
