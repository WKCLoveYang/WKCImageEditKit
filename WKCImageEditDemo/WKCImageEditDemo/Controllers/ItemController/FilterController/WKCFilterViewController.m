//
//  WKCFilterViewController.m
//  WKCImageEditDemo
//
//  Created by WeiKunChao on 2019/5/15.
//  Copyright © 2019 FaceMoji. All rights reserved.
//

#import "WKCFilterViewController.h"
#import <Masonry.h>
#import "WKCFilterItemCell.h"

#import <UIImage+Filter.h>

@interface WKCFilterViewController ()
<UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) NSDictionary * dataSource;

@end

@implementation WKCFilterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Filter";
    
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.collectionView];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(50);
        make.leading.trailing.equalTo(self.view);
        make.height.mas_equalTo(self.view.mas_width);
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-50);
        make.height.mas_equalTo(WKCFilterItemCell.itemSize.height);
    }];
    
    _dataSource = @{
                    @(UIImageFilterTypeCurve): @"Curve",
                    @(UIImageFilterTypeChrome): @"Chrome",
                    @(UIImageFilterTypeFade): @"Fade",
                    @(UIImageFilterTypeInstant): @"Instant",
                    @(UIImageFilterTypeMono): @"Mono",
                    @(UIImageFilterTypeProcess): @"Process",
                    @(UIImageFilterTypeTonal): @"Tonal",
                    @(UIImageFilterTypeTransfer): @"Transfer"
                    };
}

#pragma mark -UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataSource.allKeys.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WKCFilterItemCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(WKCFilterItemCell.class) forIndexPath:indexPath];
    cell.title = _dataSource.allValues[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIImageFilterType type = [_dataSource.allKeys[indexPath.row] integerValue];
    
    self.imageView.image = [[UIImage imageNamed:@"bg"] filterWithType:type];
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

- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout.itemSize = WKCFilterItemCell.itemSize;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = nil;
        _collectionView.backgroundView = nil;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.contentInset = UIEdgeInsetsMake(0, 20, 0, 20);
        [_collectionView registerClass:WKCFilterItemCell.class forCellWithReuseIdentifier:NSStringFromClass(WKCFilterItemCell.class)];
    }
    
    return _collectionView;
}

@end
