//
//  WKCHomeViewController.m
//  WKCImageEditDemo
//
//  Created by WeiKunChao on 2019/5/15.
//  Copyright © 2019 FaceMoji. All rights reserved.
//

#import "WKCHomeViewController.h"
#import "WKCHomeItemCell.h"
#import <Masonry.h>

#import "WKCTextViewController.h"
#import "WKCResizeViewController.h"
#import "WKCToneViewController.h"
#import "WKCAdjustmentViewController.h"
#import "WKCFlipViewController.h"
#import "WKCCutViewController.h"
#import "WKCFilterViewController.h"
#import "WKCStickerViewController.h"
#import "WKCDrawViewController.h"
#import "WKCBlendViewController.h"


NSArray <NSString *>* WKCHomeIcons(void)
{
    return @[@"text", @"resize" ,@"tone", @"adjust", @"flip", @"filter",@"cut", @"sticker" ,@"draw", @"blend"];
}

typedef NS_ENUM(NSInteger, WKCImageEditType) {
    WKCImageEditTypeText = 0,
    WKCImageEditTypeResize,
    WKCImageEditTypeToneCurve,
    WKCImageEditTypeAdjustment,
    WKCImageEditTypeFlip,
    WKCImageEditTypeFilter,
    WKCImageEditTypeCut,
    WKCImageEditTypeSticker,
    WKCImageEditTypeDraw,
    WKCImageEditTypeBlend
};

@interface WKCHomeViewController ()
<UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray <NSNumber *> * dataSource;
@property (nonatomic, strong) UICollectionView * collectionView;

@end

@implementation WKCHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _dataSource = @[
                    @(WKCImageEditTypeText),
                    @(WKCImageEditTypeResize),
                    @(WKCImageEditTypeToneCurve),
                    @(WKCImageEditTypeAdjustment),
                    @(WKCImageEditTypeFlip),
                    @(WKCImageEditTypeFilter),
                    @(WKCImageEditTypeCut),
                    @(WKCImageEditTypeSticker),
                    @(WKCImageEditTypeDraw),
                    @(WKCImageEditTypeBlend)];
    
    [self.view addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
 
}

#pragma mark -UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WKCHomeItemCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(WKCHomeItemCell.class) forIndexPath:indexPath];
    cell.imageStr = WKCHomeIcons()[indexPath.row];
    cell.title = [WKCHomeIcons()[indexPath.row] capitalizedString];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    WKCImageEditType type = [_dataSource[indexPath.row] integerValue];
    switch (type)
    {
        case WKCImageEditTypeText:
        {
            WKCTextViewController * textVC = [[WKCTextViewController alloc] init];
            [self.navigationController pushViewController:textVC
                                                 animated:YES];
        }
            break;
            
        case WKCImageEditTypeResize:
        {
            WKCResizeViewController * resizeVC = [[WKCResizeViewController alloc] init];
            [self.navigationController pushViewController:resizeVC
                                                 animated:YES];
        }
            break;
            
        case WKCImageEditTypeToneCurve:
        {
            WKCToneViewController * toneVC = [[WKCToneViewController alloc] init];
            [self.navigationController pushViewController:toneVC animated:YES];
        }
            break;
            
        case WKCImageEditTypeAdjustment:
        {
            WKCAdjustmentViewController * adjustmentVC = [[WKCAdjustmentViewController alloc] init];
            [self.navigationController pushViewController:adjustmentVC
                                                 animated:YES];
        }
            break;
            
        case WKCImageEditTypeFlip:
        {
            WKCFlipViewController * flipVC = [[WKCFlipViewController alloc] init];
            [self.navigationController pushViewController:flipVC
                                                 animated:YES];
        }
            break;
            
        case WKCImageEditTypeFilter:
        {
            WKCFilterViewController * filterVC = [[WKCFilterViewController alloc] init];
            [self.navigationController pushViewController:filterVC
                                                 animated:YES];
        }
            break;
            
        case WKCImageEditTypeCut:
        {
            WKCCutViewController * cutVC = [[WKCCutViewController alloc] init];
            [self.navigationController pushViewController:cutVC
                                                 animated:YES];
        }
            break;
            
        case WKCImageEditTypeSticker:
        {
            WKCStickerViewController * stickerVC = [[WKCStickerViewController alloc] init];
            [self.navigationController pushViewController:stickerVC
                                                 animated:YES];
        }
            break;
            
        case WKCImageEditTypeDraw:
        {
            WKCDrawViewController * drawVC = [[WKCDrawViewController alloc] init];
            [self.navigationController pushViewController:drawVC
                                                 animated:YES];
        }
            break;
            
        case WKCImageEditTypeBlend:
        {
            WKCBlendViewController * blendVC = [[WKCBlendViewController alloc] init];
            [self.navigationController pushViewController:blendVC
                                                 animated:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark -Property
- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 15;
        layout.minimumInteritemSpacing = 15;
        layout.itemSize = WKCHomeItemCell.itemSize;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundView = nil;
        _collectionView.backgroundColor = nil;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.layer.masksToBounds = NO;
        _collectionView.contentInset = UIEdgeInsetsMake(20, 15, 30, 15);
        [_collectionView registerClass:WKCHomeItemCell.class forCellWithReuseIdentifier:NSStringFromClass(WKCHomeItemCell.class)];
    }
    
    return _collectionView;
}

@end
