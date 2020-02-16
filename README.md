# 小圆点 / PageControl - OC 版

## ✨支持自定义

- 形状：圆形、方形。
- 大小。
- 间距。
- 颜色。

###### （如果下面的图挂了，请在梯子中添加域名 githubusercontent.com）

![img](https://github.com/wayone/WOPageControl/blob/master/animation.gif)

## ✨示例代码
```objective-c
// 添加控件
self.pageControl = [[WOPageControl alloc] initWithFrame:CGRectMake(110, 200, 200, 4)];
[self.view addSubview:self.pageControl];

self.pageControl.cornerRadius = 5;
self.pageControl.dotHeight = 10;
self.pageControl.dotSpace = 24;
self.pageControl.currentDotWidth = 20;
self.pageControl.otherDotWidth = 10;
self.pageControl.otherDotColor = [UIColor colorWithRed:232/255.0 green:234/255.0 blue:236/255.0 alpha:1];
self.pageControl.currentDotColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1];
self.pageControl.numberOfPages = 5;

// 修改当前页
self.pageControl.currentPage = 1