##最近工作中用到绘图功能，自己写的小Demo，基本都是CALayer+UIBezierPath组合的动画，留存，以便后面用到时回来查看 ,所有的图形绘制都是轻量级的，一个文件一个图，支持xib,和代码布局，支持横竖屏，使用简单

###Demo介绍

1. GradientLayerDemo  - CAGradientLayer实现的可以渐变的圆环，带动画，可以自由定制渐变颜色比，以及圆环动画的百分比

![](https://github.com/qqcc1388/TYChartDemo/blob/master/source/ezgif.com-video-to-gif -jianbian.gif)

2. DrawLine - 一款轻量级的，可以绘制波形图的demo,支持正数和负数

![](https://github.com/qqcc1388/TYChartDemo/blob/master/source/ezgif.com-video-to-gif boxingtu.gif)

3. ESHistogramDemo - 柱状图 - 带动画， 带标注 代码基本上都是用CAShaperLayer + BezierPath实现，绘制文字和坐标这些可以用BezierPath在CGRect方法中实现

![](https://github.com/qqcc1388/TYChartDemo/blob/master/source/ezgif.com-video-to-gif_zhuzhuang.gif)

4. ESOriginalWaveform - 波形图和柱状图结合的demo,工作用到的

![](https://github.com/qqcc1388/TYChartDemo/blob/master/source/ezgif.com-gif-maker-bz.gif)

5. OctopusFigureDemo - 八爪图或者说是雷达图，支持动画过渡，在CGRect中绘制文字和八爪图背景，利用CAShapeLayer + BezierPath实现描点绘图，利用CAReplicatorLayer实现动画的过度残影效果，CABasicAnimation的Path动画，实现动画效果

![](https://github.com/qqcc1388/TYChartDemo/blob/master/source/ezgif.com-video-to-gif-Leida.gif)