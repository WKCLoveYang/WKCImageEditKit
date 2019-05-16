//
//  WKCStickerItemView.m
//  ddasd
//
//  Created by WeiKunChao on 2019/5/14.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import "WKCStickerItemView.h"

@implementation WKCStickerItemView

- (void)setShouldActivity:(BOOL)shouldActivity
{
    self.isBorderActivity = shouldActivity;
    self.isControlActivity = shouldActivity;
}

- (instancetype)initWithContentFrame:(CGRect)frame contentImage:(UIImage *)image
{
    if (self = [super initWithContentFrame:frame contentImage:image controlSize:CGSizeMake(24, 24)])
    {
        self.isBorderActivity = YES;
        self.isControlActivity = YES;
        
        self.borderColor = UIColor.whiteColor;
        self.borderWidth = 2;
        
    }
    return self;
}

- (void)setDataSource:(id<WKCStickerItemViewDataSource>)dataSource
{
    _dataSource = dataSource;
    
    if ([dataSource respondsToSelector:@selector(stickerViewRorationImage:)])
    {
        UIImage * rorationImage = [dataSource stickerViewRorationImage:self];
        if (rorationImage) self.rorationImage = rorationImage;
    }
    
    if ([dataSource respondsToSelector:@selector(stickerViewDeleteImage:)])
    {
        UIImage * deleteImage = [dataSource stickerViewDeleteImage:self];
        if (deleteImage) self.deleteImage = deleteImage;
    }
    
    if ([dataSource respondsToSelector:@selector(stickerViewLeftBottomImage:)])
    {
        UIImage * leftBottomImage = [dataSource stickerViewLeftBottomImage:self];
        if (leftBottomImage) self.leftBottomImage = leftBottomImage;
    }
    
    if ([dataSource respondsToSelector:@selector(stickerViewRightTopImage:)])
    {
        UIImage * rightTopImage = [dataSource stickerViewRightTopImage:self];
        if (rightTopImage) self.rightTopImage = rightTopImage;
    }
}


@end
