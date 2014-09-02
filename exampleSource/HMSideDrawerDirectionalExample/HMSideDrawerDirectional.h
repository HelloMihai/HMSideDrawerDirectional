//
//  Created by Hello Mihai on 8/19/14.
//  Available under the MIT License. See the LICENSE file for more.
//

#import <Foundation/Foundation.h>

@protocol HMSideDrawerDirectionalDelegate <NSObject>

@optional
- (void)sideDrawerWillAppearWithAnimationTime:(NSTimeInterval)animationTime;
- (void)sideDrawerWillHideWithAnimationTime:(NSTimeInterval)animationTime;
- (void)sideDrawerDidAppear;
- (void)sideDrawerDidHide;
@end

static int const HMSideDrawerDirectional_SIDE_DRAWER_DIRECTION_LEFT  = -1;
static int const HMSideDrawerDirectional_SIDE_DRAWER_DIRECTION_RIGHT = 1;
static float const HMSideDrawerDirectional_DEGREE_NONE               = 0; // no angle rotation is applied
static float const HMSideDrawerDirectional_DEFAULT_DEGREE            = 25;
static float const HMSideDrawerDirectional_DEFAULT_SCALE             = 0.75;
static float const HMSideDrawerDirectional_DEFAULT_DURATION_SHOW     = 0.5;
static float const HMSideDrawerDirectional_DEFAULT_DURATION_HIDE     = 0.25;

@interface HMSideDrawerDirectional : NSObject

// delegate for views calling the side drawer
+ (void)delegate:(UIViewController<HMSideDrawerDirectionalDelegate>*)delegate;
+ (UIViewController<HMSideDrawerDirectionalDelegate>*)delegate;

// initialization
+ (void)initWithWindow:(UIWindow*)withWindow
          withViewController:(UIViewController*)withViewController
             withShrinkScale:(CGFloat)withShrinkScale
       withShowAnimationTime:(NSTimeInterval)withShowAnimationTime
       withHideAnimationTime:(NSTimeInterval)withHideAnimationTime
    withRotationDegreesAngle:(CGFloat)withRotationDegreesAngle
               withDirection:(int)withDirection;

// show hide for a specific view controller
+ (void)toggleMenuFromViewController:(UIViewController*)fromViewController;
+ (void)hideSideDrawer;

@end
