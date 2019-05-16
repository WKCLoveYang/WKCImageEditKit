# WKCImageEditKit

图片编辑工具, 一些基础的图片编辑功能.每个工具的基础项目,基本都可以自定义.

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application) [![CocoaPods compatible](https://img.shields.io/cocoapods/v/WKCImageEditKit.svg?style=flat)](https://cocoapods.org/pods/WKCImageEditKit) [![License: MIT](https://img.shields.io/cocoapods/l/WKCImageEditKit.svg?style=flat)](http://opensource.org/licenses/MIT)

` pod 'WKCImageEditKit'`

## 属性、方法

### Content(主视图)

属性 | 类型 | 含义 
------------- | ------------- | -------------
contentImage | UIImage | 待编辑的图片
contentImageView | UIImageView | 待编辑的图片视图(只读)
currentImage | UIImage | 当前编辑后的图片
isBoundaryClip | BOOL | 超出边界是否裁剪, 默认YES

```swift
- (void)reCall; //撤销
- (void)confirm; //确定
```


### Text(添加文本)

属性 | 类型 | 含义 
------------- | ------------- | -------------
textString | NSAttributedString | 赋值后会增加一个文案
textRorationImage | UIImage | 旋转按钮icon
textDeleteImage | UIImage | 删除按钮icon
textLeftBottomImage | UIImage | 左下角icon
textRightTopImage |  UIImage | 右下角icon
textIsBorderContinue | BOOL | 边框是否锯齿效果
textBorderWidth | CGFloat | 边框宽度
textBorderColor | UIColor | 边框颜色
textMinScale | CGFloat | 最小比例, 默认0.5
textMaxScale | CGFloat | 最大比例, 默认2.0
textLimitCount | NSInteger | 最多可以有几个文案, 默认5

```swift
// 刷新文案
- (void)refreshTextString:(NSAttributedString *)textString;
```

 ![Alt text](https://github.com/WKCLoveYang/WKCImageEditKit/raw/master/screenShort/text.png).
 
 
 ### Resize(尺寸调整)
 
 属性 | 类型 | 含义 
 ------------- | ------------- | -------------
 resizeImageSize | CGSize | 要更改的size
 
  ![Alt text](https://github.com/WKCLoveYang/WKCImageEditKit/raw/master/screenShort/resize.png).
  
  ### Adjustment(曝光、亮度等调节)
  
  属性 | 类型 | 含义 
  ------------- | ------------- | -------------
  adjustmentExposure | CGFloat | 曝光(-1,1), 默认0
  adjustmentBrightness | CGFloat | 亮度(-1,1), 默认0
  adjustmentContrast | CGFloat | 对比度(0,4), 默认1
  adjustmentSaturation | CGFloat | 饱和度(0,2), 默认1
  adjustmentIntensity | CGFloat | 色温(0,1), 默认1
  adjustmentAngle | CGFloat | 色调(-3.14,3.14), 默认0
  adjustmentBlur | CGFloat | 模糊(0,100), 默认10
  adjustmentShadow | CGFloat | 阴影高亮(0.3,1), 默认1
  
  ### Flip(翻转)
  
  ```swift
  - (void)flipFixOrientation; // 修正方向
  - (void)flipVertical; //垂直方向翻转
  - (void)flipHorizontal; //水平方向翻转
  - (void)flipByDegrees:(CGFloat)degrees; // 按角度旋转 例如 90
```

  ![Alt text](https://github.com/WKCLoveYang/WKCImageEditKit/raw/master/screenShort/flip.png).
  
  ### Filter(滤镜)
  
  ```swift
  - (void)filterWithType:(UIImageFilterType)type;
``` 
  ![Alt text](https://github.com/WKCLoveYang/WKCImageEditKit/raw/master/screenShort/filter.png).
  
  
  
  
  
   
