//
//  MenuView.h
//  SelectView
//
//  Created by Yuan on 16/7/3.
//  Copyright (c) 2016年 Yuan. All rights reserved.
//

#import <UIKit/UIKit.h>

// MenuView 显示类型
typedef NS_ENUM(NSInteger, MenuViewStyle) {
    MenuViewStyleDefault = 0,
    
};

// MenuView 箭头位置
typedef NS_ENUM(NSInteger, ArrowDirection) {
    ArrowDirectionDefault = 0,  // 无箭头
    ArrowDirectionLeft,
    ArrowDirectionRight,
    ArrowDirectionMiddle
};



@protocol UIAlertViewDelegate;
@class UILabel, UIToolbar, UITabBar, UIWindow, UIBarButtonItem, UIPopoverController;

@interface MenuView : UIView

- (instancetype)initWithPoint:(CGPoint)point inView:(UIView *)fromeView;

@property(nonatomic,assign) id delegate;       // weak reference

@property(nonatomic,readonly) NSInteger numberOfButtons;

@property(nonatomic,strong) UIColor *fillColor;

@property(nonatomic,readonly,getter=isVisible) BOOL visible;

// ArrowDirection -style defaults to ArrowDirectionDefault
@property(nonatomic,assign) ArrowDirection arrowDirection;

// MenuViewStyle -style defaults to MenuViewStyleDefault
@property(nonatomic,assign) MenuViewStyle menuStyle;


// shows popup alert animated.
- (void)show;


@end

@protocol MenuViewDelegate <NSObject>
@optional

// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)menuView:(MenuView *)menuView clickedButtonAtIndex:(NSInteger)buttonIndex;

// Called when we cancel a view (eg. the user clicks the Home button). This is not called when the user clicks the cancel button.
// If not defined in the delegate, we simulate a click in the cancel button
- (void)menuViewDismiss:(MenuView *)menuView;


- (void)willPresentMenuView:(MenuView *)menuView;  // before animation and showing view
- (void)didPresentMenuView:(MenuView *)menuView;   // after animation


- (void)menuView:(MenuView *)menuView willDismissWithButtonIndex:(NSInteger)buttonIndex; // before animation and hiding view
- (void)menuView:(MenuView *)menuView didDismissWithButtonIndex:(NSInteger)buttonIndex;  // after animation


@end
