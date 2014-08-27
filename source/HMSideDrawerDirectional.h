//
//  Created by Hello Mihai on 8/19/14.
//  Available under the MIT License. See the LICENSE file for more.
//

#import <Foundation/Foundation.h>

@protocol HMSideDrawerDirectionalDelegate <NSObject>

@optional
- (void)sideDrawerWillAppearWithAnimationTime:(NSTimeInterval)animationTime;
- (void)sideDrawerDidAppear;
- (void)sideDrawerWillHideWithAnimationTime:(NSTimeInterval)animationTime;
- (void)sideDrawerDidHide;

@end

static int const SIDE_DRAWER_DIRECTION_LEFT = 1;
static int const SIDE_DRAWER_DIRECTION_RIGHT = 2;

@interface HMSideDrawerDirectional : NSObject

// delegate
+ (void)delegate:(id<HMSideDrawerDirectionalDelegate>)delegate;
+ (id<HMSideDrawerDirectionalDelegate>)delegate;

// initialization
+ (void)initWithWindow:(UIWindow*)withWindow
       withViewController:(UIViewController*)withViewController
          withShrinkScale:(CGFloat)withShrinkScale
    withShowAnimationTime:(NSTimeInterval)withShowAnimationTime
    withHideAnimationTime:(NSTimeInterval)withHideAnimationTime
            withDirection:(int)withDirection;

// show hide for a specific view controller
+ (void)toggleMenuFromViewController:(UIViewController*)fromViewController;
+ (void)hideSideDrawer;

@end
