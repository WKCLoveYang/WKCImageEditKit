//
//  WKCTextItemView.m
//  ddasd
//
//  Created by WeiKunChao on 2019/5/14.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import "WKCTextItemView.h"

@implementation WKCTextItemView

- (void)setShouldActivity:(BOOL)shouldActivity
{
    self.isBorderActivity = shouldActivity;
    self.isControlActivity = shouldActivity;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithContentFrame:frame controlSize:CGSizeMake(24, 24)])
    {
        self.isBorderActivity = YES;
        self.isControlActivity = YES;
        
        self.borderColor = UIColor.whiteColor;
        self.borderWidth = 2;
    }
    return self;
}

- (void)setDataSource:(id<WKCTextItemViewDataSource>)dataSource
{
    _dataSource = dataSource;
    
    if ([dataSource respondsToSelector:@selector(textViewRorationImage:)])
    {
       UIImage * rorationImage = [dataSource textViewRorationImage:self];
       if (rorationImage) self.rorationImage = rorationImage;
    }
    
    if ([dataSource respondsToSelector:@selector(textViewDeleteImage:)])
    {
        UIImage * deleteImage = [dataSource textViewDeleteImage:self];
        if (deleteImage) self.deleteImage = deleteImage;
    }
    
    if ([dataSource respondsToSelector:@selector(textViewLeftBottomImage:)])
    {
        UIImage * leftBottomImage = [dataSource textViewLeftBottomImage:self];
        if (leftBottomImage) self.leftBottomImage = leftBottomImage;
    }
    
    if ([dataSource respondsToSelector:@selector(textViewRightTopImage:)])
    {
        UIImage * rightTopImage = [dataSource textViewRightTopImage:self];
        if (rightTopImage) self.rightTopImage = rightTopImage;
    }
}

@end
