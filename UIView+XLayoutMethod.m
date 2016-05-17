//
//  UIView+XLayoutMethod.m
//  MyCommonDemo
//
//  Created by 人和 on 16/5/17.
//  Copyright © 2016年 人和. All rights reserved.
//

#import "UIView+XLayoutMethod.h"
#import <objc/runtime.h>
@implementation UIView (XLayoutMethod)

#pragma mark - Getters/Setters
// getters
- (CGFloat)height {
    return self.frame.size.height;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x {
    self.frame = CGRectMake(x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (void)setY:(CGFloat)y {
    self.frame = CGRectMake(self.frame.origin.x, y, self.frame.size.width, self.frame.size.height);
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (CGSize)size {
    return self.frame.size;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (CGFloat)centerY {
    return self.center.y;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (CGFloat)bottom {
    return self.frame.size.height + self.frame.origin.y;
}

- (CGFloat)right {
    return self.frame.size.width + self.frame.origin.x;
}

- (void)setTop:(CGFloat)top {
    self.y = top;
}

- (void)setLeft:(CGFloat)left {
    self.x = left;
}

-(void)setBottom:(CGFloat)bottom {
    self.y = bottom - self.height;
}

-(void)setRight:(CGFloat)right {
    self.x = right - self.width;
}

// height
- (void)setHeight:(CGFloat)height {
    CGRect newFrame = CGRectMake(self.x, self.y, self.width, height);
    self.frame = newFrame;
}

- (void)heightEqualToView:(UIView *)view {
    self.height = view.height;
}

// width
- (void)setWidth:(CGFloat)width {
    CGRect newFrame = CGRectMake(self.x, self.y, width, self.height);
    self.frame = newFrame;
}

- (void)widthEqualToView:(UIView *)view {
    self.width = view.width;
}

#pragma mark - center
- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = CGPointMake(self.centerX, self.centerY);
    center.x = centerX;
    self.center = center;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = CGPointMake(self.centerX, self.centerY);
    center.y = centerY;
    self.center = center;
}

- (void)centerXEqualToView:(UIView *)view {
    if ([view isEqual:self.superview]) {
        self.centerX = floorf(view.width / 2.0);
        return;
    }

    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewCenterPoint = [superView convertPoint:view.center toView:self.topSuperView];
    CGPoint centerPoint = [self.topSuperView convertPoint:viewCenterPoint toView:self.superview];
    self.centerX = centerPoint.x;
}

- (void)centerYEqualToView:(UIView *)view {
    if ([view isEqual:self.superview]) {
        self.centerX = floorf(view.height / 2.0);
        return;
    }

    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewCenterPoint = [superView convertPoint:view.center toView:self.topSuperView];
    CGPoint centerPoint = [self.topSuperView convertPoint:viewCenterPoint toView:self.superview];
    self.centerY = centerPoint.y;
}

#pragma mark - top, bottom, left, right
- (void)top:(CGFloat)top FromView:(UIView *)view {
    if ([view isEqual:self.superview]) {
        self.y = top;
        return;
    }

    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];

    self.y = floorf(newOrigin.y + top + view.height);
}

- (void)bottom:(CGFloat)bottom FromView:(UIView *)view {
    if ([view isEqual:self.superview]) {
        self.y = view.height - bottom - self.height;
        return;
    }
    
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];

    self.y = newOrigin.y - bottom - self.height;
}

- (void)left:(CGFloat)left FromView:(UIView *)view {
    if ([view isEqual:self.superview]) {
        self.x = left;
        return;
    }

    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];

    self.x = newOrigin.x - left - self.width;
}

- (void)right:(CGFloat)right FromView:(UIView *)view {
    if ([view isEqual:self.superview]) {
        self.x = view.width - right - self.width;
        return;
    }

    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];

    self.x = newOrigin.x + right + view.width;
}
#pragma mark - top, bottom, left, right by ratio
- (void)topRatio:(CGFloat)top FromView:(UIView *)view screenType:(UIScreenType)screenType {
    CGFloat topRatio = top / screenType;
    CGFloat topValue = topRatio * self.superview.width;
    [self top:topValue FromView:view];
}

- (void)bottomRatio:(CGFloat)bottom FromView:(UIView *)view screenType:(UIScreenType)screenType {
    CGFloat bottomRatio = bottom / screenType;
    CGFloat bottomValue = bottomRatio * self.superview.width;
    [self bottom:bottomValue FromView:view];
}

- (void)leftRatio:(CGFloat)left FromView:(UIView *)view screenType:(UIScreenType)screenType {
    CGFloat leftRatio = left / screenType;
    CGFloat leftValue = leftRatio * self.superview.width;
    [self left:leftValue FromView:view];
}

- (void)rightRatio:(CGFloat)right FromView:(UIView *)view screenType:(UIScreenType)screenType {
    CGFloat rightRatio = right / screenType;
    CGFloat rightValue = rightRatio * self.superview.width;
    [self right:rightValue FromView:view];
}
#pragma mark - frame by container
- (void)topInContainer:(CGFloat)top shouldResize:(BOOL)shouldResize {
    if (shouldResize) {
        self.height = self.y - top + self.height;
    }
    self.y = top;
}

- (void)bottomInContainer:(CGFloat)bottom shouldResize:(BOOL)shouldResize {
    if (shouldResize) {
        self.height = self.superview.height - bottom - self.y;
    } else {
        self.y = self.superview.height - self.height - bottom;
    }
}

- (void)leftInContainer:(CGFloat)left shouldResize:(BOOL)shouldResize {
    if (shouldResize) {
        self.width = self.x - left + self.superview.width;
    }
    self.x = left;
}

- (void)rightInContainer:(CGFloat)right shouldResize:(BOOL)shouldResize {
    if (shouldResize) {
        self.width = self.superview.width - right - self.x;
    } else {
        self.x = self.superview.width - self.width - right;
    }
}

- (void)topRatioInContainer:(CGFloat)top shouldResize:(BOOL)shouldResize screenType:(UIScreenType)screenType {
    CGFloat topRatio = top / screenType;
    CGFloat topValue = topRatio * self.superview.width;
    [self topInContainer:topValue shouldResize:shouldResize];
}

- (void)bottomRatioInContainer:(CGFloat)bottom shouldResize:(BOOL)shouldResize screenType:(UIScreenType)screenType {
    CGFloat bottomRatio = bottom / screenType;
    CGFloat bottomValue = bottomRatio * self.superview.width;
    [self bottomInContainer:bottomValue shouldResize:shouldResize];
}

- (void)leftRatioInContainer:(CGFloat)left shouldResize:(BOOL)shouldResize screenType:(UIScreenType)screenType {
    CGFloat leftRatio = left / screenType;
    CGFloat leftValue = leftRatio * self.superview.width;
    [self leftInContainer:leftValue shouldResize:shouldResize];
}

- (void)rightRatioInContainer:(CGFloat)right shouldResize:(BOOL)shouldResize screenType:(UIScreenType)screenType {
    CGFloat rightRatio = right / screenType;
    CGFloat rightValue = rightRatio * self.superview.width;
    [self rightInContainer:rightValue shouldResize:shouldResize];
}

#pragma mark - equal to
- (void)topEqualToView:(UIView *)view {
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];

    self.y = newOrigin.y;
}

- (void)bottomEqualToView:(UIView *)view {
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];

    self.y = newOrigin.y + view.height - self.height;
}

- (void)leftEqualToView:(UIView *)view {
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];

    self.x = newOrigin.x;
}

- (void)rightEqualToView:(UIView *)view {
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];

    self.x = newOrigin.x + view.width - self.width;
}

#pragma mark - size
- (void)setSize:(CGSize)size {
    self.frame = CGRectMake(self.x, self.y, size.width, size.height);
}

- (void)sizeEqualToView:(UIView *)view {
    self.frame = CGRectMake(self.x, self.y, view.width, view.height);
}

#pragma mark - fill to super
- (void)fillWidth {
    self.width = self.superview.width;
}

- (void)fillHeight {
    self.height = self.superview.height;
}

- (void)fill {
    self.frame = CGRectMake(0, 0, self.superview.width, self.superview.height);
}
#pragma mark - UIView
- (UIView *)topSuperView {
    UIView *topSuperView = self.superview;

    if (topSuperView == nil) {
        topSuperView = self;
    } else {
        while (topSuperView.superview) {
            topSuperView = topSuperView.superview;
        }
    }

    return topSuperView;
}

- (UIView *)lastSubviewOnX {
    if(self.subviews.count > 0) {
        UIView *outView = self.subviews[0];

        for(UIView *v in self.subviews)
            if(v.x > outView.x)
                outView = v;

        return outView;
    }

    return nil;
}
- (UIView *)lastSubviewOnY {
    if(self.subviews.count > 0) {
        UIView *outView = self.subviews[0];

        for(UIView *v in self.subviews)
            if(v.y > outView.y)
                outView = v;

        return outView;
    }

    return nil;
}

#pragma mark - chain
- (XLayoutModel *)layoutModel
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setLayoutModel:(XLayoutModel *)layoutModel
{
    objc_setAssociatedObject(self, @selector(layoutModel), layoutModel, OBJC_ASSOCIATION_RETAIN);
}

- (XLayoutModel *)xL_Layout {
    NSAssert(self.superview, @"self hasn't superView");

    XLayoutModel *layoutModel = [self layoutModel];
    if (!layoutModel) {
        layoutModel = [XLayoutModel new];
        layoutModel.refView = self;
    }
    return layoutModel;
}
@end


#pragma mark - XLayoutModel
@implementation XLayoutModel
@synthesize XL_X = _XL_X;
@synthesize XL_Y = _XL_Y;
@synthesize XL_Width = _XL_Width;
@synthesize XL_Height = _XL_Height;

- (XL_Margin)XL_MarginBlockWithKey:(NSString *)key
{
    __weak typeof(self) weakSelf = self;

    return ^(CGFloat value) {
        if ([key isEqualToString:@"x"]) {
            weakSelf.refView.x = value;
        } else if ([key isEqualToString:@"y"]) {
            weakSelf.refView.y = value;
        } else if ([key isEqualToString:@"width"]) {
            weakSelf.refView.width = value;
        } else if ([key isEqualToString:@"height"]) {
            weakSelf.refView.height = value;
        }

        return weakSelf;
    };
}


- (XL_Margin)XL_X {
    if (!_XL_X) {
        _XL_X = [self XL_MarginBlockWithKey:@"x"];
    }
    return _XL_X;
}
- (XL_Margin)XL_Y {
    if (!_XL_Y) {
        _XL_Y = [self XL_MarginBlockWithKey:@"y"];
    }
    return _XL_Y;
}
- (XL_Margin)XL_Width {
    if (!_XL_Width) {
        _XL_Width = [self XL_MarginBlockWithKey:@"width"];
    }
    return _XL_Width;
}
- (XL_Margin)XL_Height {
    if (!_XL_Height) {
        _XL_Height = [self XL_MarginBlockWithKey:@"height"];
    }
    return _XL_Height;
}
@end

#pragma mark - XLAdd
@implementation UIView (XLAdd)
- (UIImage *)snapshotImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snap = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snap;
}

- (UIImage *)snapshotImageAfterScreenUpdates:(BOOL)afterUpdates {
    if (![self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        return [self snapshotImage];
    }
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:afterUpdates];
    UIImage *snap = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snap;
}

- (NSData *)snapshotPDF {
    CGRect bounds = self.bounds;
    NSMutableData *data = [NSMutableData data];
    CGDataConsumerRef consumer = CGDataConsumerCreateWithCFData((__bridge CFMutableDataRef)data);
    CGContextRef context = CGPDFContextCreate(consumer, &bounds, NULL);
    CGDataConsumerRelease(consumer);
    if (!context) return nil;
    CGPDFContextBeginPage(context, NULL);
    CGContextTranslateCTM(context, 0, bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    [self.layer renderInContext:context];
    CGPDFContextEndPage(context);
    CGPDFContextClose(context);
    CGContextRelease(context);
    return data;
}

- (void)setLayerShadow:(UIColor*)color offset:(CGSize)offset radius:(CGFloat)radius {
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowRadius = radius;
    self.layer.shadowOpacity = 1;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

- (void)removeAllSubviews {
    //[self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    while (self.subviews.count) {
        [self.subviews.lastObject removeFromSuperview];
    }
}


- (UIViewController *)viewController {
    for (UIView *view = self; view; view = view.superview) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (CGFloat)visibleAlpha {
    if ([self isKindOfClass:[UIWindow class]]) {
        if (self.hidden) return 0;
        return self.alpha;
    }
    if (!self.window) return 0;
    CGFloat alpha = 1;
    UIView *v = self;
    while (v) {
        if (v.hidden) {
            alpha = 0;
            break;
        }
        alpha *= v.alpha;
        v = v.superview;
    }
    return alpha;
}

- (CGPoint)convertPoint:(CGPoint)point toViewOrWindow:(UIView *)view {
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertPoint:point toWindow:nil];
        } else {
            return [self convertPoint:point toView:nil];
        }
    }

    UIWindow *from = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    UIWindow *to = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    if ((!from || !to) || (from == to)) return [self convertPoint:point toView:view];
    point = [self convertPoint:point toView:from];
    point = [to convertPoint:point fromWindow:from];
    point = [view convertPoint:point fromView:to];
    return point;
}

- (CGPoint)convertPoint:(CGPoint)point fromViewOrWindow:(UIView *)view {
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertPoint:point fromWindow:nil];
        } else {
            return [self convertPoint:point fromView:nil];
        }
    }

    UIWindow *from = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    UIWindow *to = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    if ((!from || !to) || (from == to)) return [self convertPoint:point fromView:view];
    point = [from convertPoint:point fromView:view];
    point = [to convertPoint:point fromWindow:from];
    point = [self convertPoint:point fromView:to];
    return point;
}

- (CGRect)convertRect:(CGRect)rect toViewOrWindow:(UIView *)view {
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertRect:rect toWindow:nil];
        } else {
            return [self convertRect:rect toView:nil];
        }
    }

    UIWindow *from = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    UIWindow *to = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    if (!from || !to) return [self convertRect:rect toView:view];
    if (from == to) return [self convertRect:rect toView:view];
    rect = [self convertRect:rect toView:from];
    rect = [to convertRect:rect fromWindow:from];
    rect = [view convertRect:rect fromView:to];
    return rect;
}

- (CGRect)convertRect:(CGRect)rect fromViewOrWindow:(UIView *)view {
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertRect:rect fromWindow:nil];
        } else {
            return [self convertRect:rect fromView:nil];
        }
    }

    UIWindow *from = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    UIWindow *to = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    if ((!from || !to) || (from == to)) return [self convertRect:rect fromView:view];
    rect = [from convertRect:rect fromView:view];
    rect = [to convertRect:rect fromWindow:from];
    rect = [self convertRect:rect fromView:to];
    return rect;
}
@end