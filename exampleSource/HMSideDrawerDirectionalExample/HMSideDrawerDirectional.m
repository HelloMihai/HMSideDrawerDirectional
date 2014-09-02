//
//  Created by Hello Mihai on 8/19/14.
//  Available under the MIT License. See the LICENSE file for more.
//

#import "HMSideDrawerDirectional.h"
#import "HMBasicAnimation.h"

UIViewController* sideViewController;
UIViewController* currentViewController;
UIButton* closeButton;
UIWindow* window;
CGFloat shrinkScale;
CGFloat rotationDegreesAngle;
NSTimeInterval showAnimationTime;
NSTimeInterval hideAnimationTime;
BOOL isShown;
int direction;
UIViewController <HMSideDrawerDirectionalDelegate>* _delegate;
UIViewController <HMSideDrawerDirectionalDelegate>* delegateSideDrawer;

@implementation HMSideDrawerDirectional

#pragma mark : accessors

+ (UIViewController<HMSideDrawerDirectionalDelegate>*)delegate
{
    return _delegate;
}

+ (void)delegate:(UIViewController<HMSideDrawerDirectionalDelegate>*)delegate
{
    _delegate = delegate;
}

#pragma mark : initialization

+ (void)initWithWindow:(UIWindow*)withWindow
       withViewController:(UIViewController <HMSideDrawerDirectionalDelegate>*)withViewController
          withShrinkScale:(CGFloat)withShrinkScale
    withShowAnimationTime:(NSTimeInterval)withShowAnimationTime
    withHideAnimationTime:(NSTimeInterval)withHideAnimationTime
 withRotationDegreesAngle:(CGFloat)withRotationDegreesAngle
            withDirection:(int)withDirection
{
    window = withWindow;
    sideViewController = withViewController;
    shrinkScale = withShrinkScale;
    showAnimationTime = withShowAnimationTime;
    hideAnimationTime = withHideAnimationTime;
    rotationDegreesAngle = withRotationDegreesAngle;
    direction = withDirection;
    
    // delegate for the side drawer
    delegateSideDrawer = withViewController;
}

+ (void)initCloseButtonToViewController:(UIViewController*)toViewController
{
    if (!closeButton) {
        closeButton = [[UIButton alloc] init];
        [closeButton addTarget:self action:@selector(tapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    CGRect frame = toViewController.view.frame;
    closeButton.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
}

#pragma mark : toggle

+ (void)hideSideDrawer
{
    if (isShown) {
        
        // delegate calls
        [[self delegate]    sideDrawerWillHideWithAnimationTime:hideAnimationTime];
        [delegateSideDrawer sideDrawerWillHideWithAnimationTime:hideAnimationTime];
        
        [[self delegate]    performSelector:@selector(sideDrawerDidHide) withObject:nil afterDelay:showAnimationTime];
        [delegateSideDrawer performSelector:@selector(sideDrawerDidHide) withObject:nil afterDelay:showAnimationTime];
        
        CGSize windowSize = window.frame.size;
        
        // remove the button
        [closeButton removeFromSuperview];
        [UIView animateWithDuration:hideAnimationTime animations:^{
            // move the view back to the main position
            currentViewController.view.center = CGPointMake(windowSize.width/2, windowSize.height/2); // animate half off the screen
            currentViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1); // grow back to full scale
        } completion:^(BOOL finished) {
            if (finished) {
                [window addSubview:currentViewController.view]; // set the view back on the window since for the animation it was set to the sideMenu viewControllers view
                [sideViewController.view removeFromSuperview]; // remove the side view from the window
                currentViewController = nil; // stop holding onto the presented view
            }
        }];
        isShown = NO;
    }
}

+ (void)toggleMenuFromViewController:(UIViewController*)fromViewController
{
    // show sub view controller on the side
    if (!isShown) {
        
        currentViewController = fromViewController; // hold onto the presented view to remove when hiding
        
        CGSize windowSize = window.frame.size;
        UIView* view      = currentViewController.view;
        CALayer* layer    = view.layer;
        
        [window addSubview:sideViewController.view]; // add the side view
        [sideViewController.view addSubview:currentViewController.view];// add the preview view on the menu view
        [currentViewController.view.superview bringSubviewToFront:currentViewController.view]; // bring the presented view on top
        
        // add button covering entire view so when tapped can return
        [self initCloseButtonToViewController:currentViewController];
        [currentViewController.view addSubview:closeButton];
        
        // animation references

        CGFloat delaySeconds = 0;
        if (rotationDegreesAngle != HMSideDrawerDirectional_DEGREE_NONE)
            [HMBasicAnimation doRotate3DAnimation:layer toDegreeAngle:direction * rotationDegreesAngle    duration:showAnimationTime delaySeconds:delaySeconds keyPath:HMBasicAnimation_ROTATION_Y];
        [HMBasicAnimation doAnimation:layer             toValue:@(shrinkScale)                            duration:showAnimationTime delaySeconds:delaySeconds keyPath:HMBasicAnimation_SCALE_X];
        [HMBasicAnimation doAnimation:layer             toValue:@(shrinkScale)                            duration:showAnimationTime delaySeconds:delaySeconds keyPath:HMBasicAnimation_SCALE_Y];
        [HMBasicAnimation doAnimation:layer             toValue:@(direction * windowSize.width / 2)       duration:showAnimationTime delaySeconds:delaySeconds keyPath:HMBasicAnimation_TRANSLATION_X];
        
        isShown = YES;
        
        // delegate calls
        [[self delegate]    sideDrawerWillAppearWithAnimationTime:showAnimationTime];
        [delegateSideDrawer sideDrawerWillAppearWithAnimationTime:showAnimationTime];
        
        [[self delegate]    performSelector:@selector(sideDrawerDidAppear) withObject:nil afterDelay:showAnimationTime];
        [delegateSideDrawer performSelector:@selector(sideDrawerDidAppear) withObject:nil afterDelay:showAnimationTime];
    } else {
        [self hideSideDrawer];
    }
}

+ (void)tapped:(id)sender
{
    [self hideSideDrawer];
}

@end
