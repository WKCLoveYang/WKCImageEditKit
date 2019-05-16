# WKCImageEditKit

图片编辑工具, 一些基础的图片编辑功能.每个工具的基础项目,基本都可以自定义.

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application) [![CocoaPods compatible](https://img.shields.io/cocoapods/v/WKCImageEditKit.svg?style=flat)](https://cocoapods.org/pods/WKCImageEditKit) [![License: MIT](https://img.shields.io/cocoapods/l/WKCImageEditKit.svg?style=flat)](http://opensource.org/licenses/MIT)

` pod 'WKCImageEditKit'`

## 属性

### Content(主视图)

属性 | 类型 | 含义 
------------- | ------------- | -------------
contentImage | UIImage | 待编辑的图片
contentImageView | UIImageView | 待编辑的图片视图(只读)
currentImage | UIImage | 当前编辑后的图片
isBoundaryClip | BOOL | 超出边界是否裁剪, 默认YES

方法 | 含义
------------- | -------------
- (void)reCall | 撤销上次操作
- (void)confirm | 确定

