# XLayout && Convenience
Light-weighted Layout By UIView Category And Contain Other Common Useful Method


## Why to build a duplicate wheel？

There are so many third libraries to solve view's layouts. Such as [Masonry](https://github.com/SnapKit/Masonry) [PureLayout](https://github.com/PureLayout/PureLayout) [SDAutoLayout](https://github.com/gsdios/SDAutoLayout). As for me,Sometime I don't need to use these oversize libraries.It's very handy to use view's category.So I Write XLayout.

It bases on view's frame layout.Before you use this category,this view must has a superview just as Masonry.

## How To Use

It's very very easy to use this category.Not only support tranditoinanl frame setting,aslo Support chain syntax.

### For Example && Feature:

* Base Use：convenient set frame

```view.width = 10;
    view.height = 10;
    view.x = 10;
    view.y = 10;
    view.bottom = 10;
    view.right = 10;
```

---

* Margin View Use: Just by ratio

```
[view topRatio:10 FromView:self.view screenType:XL_UIScreenType_iPhone6];
[view leftRatio:10 FromView:self.view screenType:XL_UIScreenType_iPhone5];
```
---

* chain syntax: Just margin to superview

```
view.xL_Layout.XL_X(20).XL_Y(30).XL_Width(100).XL_Height(300);
```
---

* calculateLayout protocal

In general,We must layout our views aflter we create views. So I define required protocal to check this rule.In ``layoutSubview`` fucntion,we call this protocal.

* Other Common Method

There are so much method we could use.Such as snap image ,remove all subviews,return viewcontroller...

here there are:

```
@property (nullable, nonatomic, readonly) UIViewController *viewController;
@property (nonatomic, readonly) CGFloat visibleAlpha;
- (nullable UIImage *)snapshotImage;
- (nullable UIImage *)snapshotImageAfterScreenUpdates:(BOOL)afterUpdates;
- (nullable NSData *)snapshotPDF;
- (void)setLayerShadow:(nullable UIColor*)color offset:(CGSize)offset radius:(CGFloat)radius;
- (void)removeAllSubviews;
- (CGPoint)convertPoint:(CGPoint)point toViewOrWindow:(nullable UIView *)view;
- (CGPoint)convertPoint:(CGPoint)point fromViewOrWindow:(nullable UIView *)view;
- (CGRect)convertRect:(CGRect)rect toViewOrWindow:(nullable UIView *)view;
- (CGRect)convertRect:(CGRect)rect fromViewOrWindow:(nullable UIView *)view;
```

Have Fun!




