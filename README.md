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
  
  
  ### Sticker(贴纸)
  
  属性 | 类型 | 含义 
  ------------- | ------------- | -------------
  stickerImage | UIImage | 贴图, 赋值及增加一个贴图
  stickerRorationImage | UIImage | 旋转按钮Icon
  stickerDeleteImage | UIImage | 删除按钮Icon
  stickerLeftBottomImage | UIImage | 左下角按钮Icon
  stickerRightTopImage | UIImage | 右下角按钮Icon
  stickerIsBorderContinue | BOOL | 是否锯齿
  stickerBorderWidth | CGFloat | 边框宽度
  stickerBorderColor | UIColor | 边框颜色
  stickerMinScale | CGFloat | 最小比例, 默认0.5
  stickerMaxScale | CGFloat | 最大比例, 默认2.0
  stickerLimitCount | NSInteger | 最多可以有几个贴纸, 默认5
  
  ![Alt text](https://github.com/WKCLoveYang/WKCImageEditKit/raw/master/screenShort/sticker.png).
  
  ### Draw(画笔)
  
  属性 | 类型 | 含义 
  ------------- | ------------- | -------------
  drawCouldUse | BOOL | 是否开启画笔功能
  drawLineColor | UIColor | 画笔颜色
  drawLineWidth | CGFloat | 画笔宽度
  
  ```swift 
  - (void)drawClear; //清屏draw
  - (void)drawRevoke; //撤销
  - (void)drawErase; //擦除功能开启
```

![Alt text](https://github.com/WKCLoveYang/WKCImageEditKit/raw/master/screenShort/draw.png).

### ToneCurve(颜色曲线)

属性 | 类型 | 含义 
------------- | ------------- | -------------
toneCouldUse | BOOL | 是否开启ToneCurve功能
toneGridColor | UIColor | 网格颜色, 默认黑色
toneGridWidth | CGFloat | 网格宽度, 默认1
tonePointColor | UIColor | 点颜色, 默认黑色
toneLineColor | UIColor | 线框颜色
toneLineWidth | CGFloat | 线框宽度

![Alt text](https://github.com/WKCLoveYang/WKCImageEditKit/raw/master/screenShort/tone.png).

### Cut(裁剪)

属性 | 类型 | 含义 
------------- | ------------- | -------------
cutCouldUse | BOOL | 是否开启cut功能
cutNeedScaleCrop | BOOL | 是否需要按比例裁剪
cutShowMidLines | BOOL | 是否需要展示四边中间的凸起
cutShowCrossLines | BOOL | 是否显示交叉线
cutCornerBorderInImage | BOOL | 边框的四个角是否可以超出图片显示
cutCropAspectRatio | CGFloat | 边框的颜色
cutCropAreaBorderLineColor | UIColor | 边框的颜色
cutCropAreaBorderLineWidth | CGFloat | 边框的线宽
cutCropAreaCornerLineColor | UIColor | 边框四个角的颜色
cutCropAreaCornerLineWidth | CGFloat | 边框四个角的线宽
cutCropAreaCornerWidth | CGFloat | 边框角横边的长度
cutCropAreaCornerHeight | CGFloat | 边框角竖边的长度
cutMinSpace | CGFloat | 相邻角之间的最小距离
cutCropAreaCrossLineWidth | CGFloat | 交叉线的宽度
cutCropAreaCrossLineWidth | UIColor | 交叉线的颜色
cutCropAreaMidLineWidth | CGFloat | 边框每条边中间线的长度
cutCropAreaMidLineHeight | CGFloat | 边框每条边中间线的线宽
cutCropAreaMidLineColor | UIColor | 边框每条边中间线的颜色
cutMaskColor | UIColor | 裁剪区域的蒙板颜色

![Alt text](https://github.com/WKCLoveYang/WKCImageEditKit/raw/master/screenShort/cut.png).


如果要只单独使用某个功能,可以单独将其提出. 具体的功能分类如下：

```swift
#import "WKCTextItemView.h" // Text
#import "UIImage+Resize.h" // Resize
#import "WKCToneCurveView.h" //WKCToneCurveView
#import "UIImage+Adjustment.h" //Adjustment
#import "UIImage+Flip.h" //Flip
#import "UIImage+Filter.h" //Filter
#import "WKCCutView.h" //Cut
#import "WKCStickerItemView.h" //Sticker
#import "WKCDrawContentView.h" //Draw
````









  
  
  
  
  
  
  
  
  
  
  
  
   
