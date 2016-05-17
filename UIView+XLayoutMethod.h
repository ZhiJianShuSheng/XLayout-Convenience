//
//  UIView+XLayoutMethod.h
//  MyCommonDemo
//
//  Created by 人和 on 16/5/17.
//  Copyright © 2016年 人和. All rights reserved.
//

#import <UIKit/UIKit.h>
/**

 */
@class XLayoutModel;

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define SCREEN_WIDTH ([[UIScreen mainScreen]bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen]bounds].size.height)
#define SCREEN_WITHOUT_STATUS_HEIGHT (SCREEN_HEIGHT - [[UIApplication sharedApplication] statusBarFrame].size.height)


typedef CGFloat UIScreenType;
static UIScreenType XL_UIScreenType_iPhone6 = 375.0f;
static UIScreenType XL_UIScreenType_iPhone5 = 320.0f;
@interface UIView (XLayoutMethod)

// getters
- (CGFloat)x;
- (CGFloat)y;
- (CGFloat)height;
- (CGFloat)width;
- (CGPoint)origin;
- (CGFloat)centerX;
- (CGFloat)centerY;

- (CGFloat)left;
- (CGFloat)top;
- (CGFloat)bottom;
- (CGFloat)right;
- (CGSize)size;

- (void)setX:(CGFloat)x;
- (void)setY:(CGFloat)y;
- (void)setTop:(CGFloat)top;
- (void)setBottom:(CGFloat)bottom;
- (void)setLeft:(CGFloat)left;
- (void)setRight:(CGFloat)right;

// height
- (void)setHeight:(CGFloat)height;
- (void)heightEqualToView:(nullable UIView *)view;

// width
- (void)setWidth:(CGFloat)width;
- (void)widthEqualToView:(nullable UIView *)view;

// center
- (void)setCenterX:(CGFloat)centerX;
- (void)setCenterY:(CGFloat)centerY;
- (void)centerXEqualToView:(nullable UIView *)view;
- (void)centerYEqualToView:(nullable UIView *)view;

// top, bottom, left, right
- (void)top:(CGFloat)top FromView:(nullable UIView *)view;
- (void)bottom:(CGFloat)bottom FromView:(nullable UIView *)view;
- (void)left:(CGFloat)left FromView:(nullable UIView *)view;
- (void)right:(CGFloat)right FromView:(nullable UIView *)view;

- (void)topRatio:(CGFloat)top FromView:(nullable UIView *)view screenType:(UIScreenType)screenType;
- (void)bottomRatio:(CGFloat)bottom FromView:(nullable UIView *)view screenType:(UIScreenType)screenType;
- (void)leftRatio:(CGFloat)left FromView:(nullable UIView *)view screenType:(UIScreenType)screenType;
- (void)rightRatio:(CGFloat)right FromView:(nullable UIView *)view screenType:(UIScreenType)screenType;

// container
- (void)topInContainer:(CGFloat)top shouldResize:(BOOL)shouldResize;
- (void)bottomInContainer:(CGFloat)bottom shouldResize:(BOOL)shouldResize;
- (void)leftInContainer:(CGFloat)left shouldResize:(BOOL)shouldResize;
- (void)rightInContainer:(CGFloat)right shouldResize:(BOOL)shouldResize;

// ratio container
- (void)topRatioInContainer:(CGFloat)top shouldResize:(BOOL)shouldResize screenType:(UIScreenType)screenType;
- (void)bottomRatioInContainer:(CGFloat)bottom shouldResize:(BOOL)shouldResize screenType:(UIScreenType)screenType;
- (void)leftRatioInContainer:(CGFloat)left shouldResize:(BOOL)shouldResize screenType:(UIScreenType)screenType;
- (void)rightRatioInContainer:(CGFloat)right shouldResize:(BOOL)shouldResize screenType:(UIScreenType)screenType;

// equal
- (void)topEqualToView:(nullable UIView *)view;
- (void)bottomEqualToView:(nullable UIView *)view;
- (void)leftEqualToView:(nullable UIView *)view;
- (void)rightEqualToView:(nullable UIView *)view;

// size
- (void)setSize:(CGSize)size;
- (void)sizeEqualToView:(nullable UIView *)view;

// fill to super
- (void)fillWidth;
- (void)fillHeight;
- (void)fill;

// view
- (nullable UIView *)topSuperView;
- (nullable UIView *)lastSubviewOnX;
- (nullable UIView *)lastSubviewOnY;

// chain
@property (nullable,nonatomic, readonly, strong) XLayoutModel *layoutModel;
- (nullable XLayoutModel *)xL_Layout;

@end

typedef XLayoutModel* (^XL_Margin)(CGFloat value);

@interface XLayoutModel : NSObject

@property (nullable, nonatomic, weak) UIView *refView;

@property (nullable, nonatomic, readonly, copy) XL_Margin XL_X;
@property (nullable, nonatomic, readonly, copy) XL_Margin XL_Y;
@property (nullable, nonatomic, readonly, copy) XL_Margin XL_Width;
@property (nullable, nonatomic, readonly, copy) XL_Margin XL_Height;

@end

@protocol LayoutProtocol
@required
// put your layout code here
- (void)calculateLayout;
@end


@interface UIView (XLAdd)

/**
 Create a snapshot image of the complete view hierarchy.
 */
- (nullable UIImage *)snapshotImage;

/**
 Create a snapshot image of the complete view hierarchy.
 @discussion It's faster than "snapshotImage", but may cause screen updates.
 See -[UIView drawViewHierarchyInRect:afterScreenUpdates:] for more information.
 */
- (nullable UIImage *)snapshotImageAfterScreenUpdates:(BOOL)afterUpdates;

/**
 Create a snapshot PDF of the complete view hierarchy.
 */
- (nullable NSData *)snapshotPDF;

/**
 Shortcut to set the view.layer's shadow

 @param color  Shadow Color
 @param offset Shadow offset
 @param radius Shadow radius
 */
- (void)setLayerShadow:(nullable UIColor*)color offset:(CGSize)offset radius:(CGFloat)radius;

/**
 Remove all subviews.

 @warning Never call this method inside your view's drawRect: method.
 */
- (void)removeAllSubviews;

/**
 Returns the view's view controller (may be nil).
 */
@property (nullable, nonatomic, readonly) UIViewController *viewController;

/**
 Returns the visible alpha on screen, taking into account superview and window.
 */
@property (nonatomic, readonly) CGFloat visibleAlpha;

/**
 Converts a point from the receiver's coordinate system to that of the specified view or window.

 @param point A point specified in the local coordinate system (bounds) of the receiver.
 @param view  The view or window into whose coordinate system point is to be converted.
 If view is nil, this method instead converts to window base coordinates.
 @return The point converted to the coordinate system of view.
 */
- (CGPoint)convertPoint:(CGPoint)point toViewOrWindow:(nullable UIView *)view;

/**
 Converts a point from the coordinate system of a given view or window to that of the receiver.

 @param point A point specified in the local coordinate system (bounds) of view.
 @param view  The view or window with point in its coordinate system.
 If view is nil, this method instead converts from window base coordinates.
 @return The point converted to the local coordinate system (bounds) of the receiver.
 */
- (CGPoint)convertPoint:(CGPoint)point fromViewOrWindow:(nullable UIView *)view;

/**
 Converts a rectangle from the receiver's coordinate system to that of another view or window.

 @param rect A rectangle specified in the local coordinate system (bounds) of the receiver.
 @param view The view or window that is the target of the conversion operation. If view is nil, this method instead converts to window base coordinates.
 @return The converted rectangle.
 */
- (CGRect)convertRect:(CGRect)rect toViewOrWindow:(nullable UIView *)view;

/**
 Converts a rectangle from the coordinate system of another view or window to that of the receiver.

 @param rect A rectangle specified in the local coordinate system (bounds) of view.
 @param view The view or window with rect in its coordinate system.
 If view is nil, this method instead converts from window base coordinates.
 @return The converted rectangle.
 */
- (CGRect)convertRect:(CGRect)rect fromViewOrWindow:(nullable UIView *)view;

@end

