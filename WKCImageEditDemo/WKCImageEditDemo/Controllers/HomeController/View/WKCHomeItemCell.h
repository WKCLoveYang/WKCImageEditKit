//
//  WKCHomeItemCell.h
//  WKCImageEditDemo
//
//  Created by WeiKunChao on 2019/5/15.
//  Copyright © 2019 FaceMoji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKCHomeItemCell : UICollectionViewCell

@property (class, nonatomic, assign, readonly) CGSize itemSize;

@property (nonatomic, strong) NSString * imageStr;
@property (nonatomic, strong) NSString * title;

@end

