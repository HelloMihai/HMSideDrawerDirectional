//
//  Created by Hello Mihai on 8/19/14.
//  Available under the MIT License. See the LICENSE file for more.
//

#import "HMSideDrawerDirectional.h"

UIViewController* sideViewController;
UIViewController* currentViewController;
UIButton* closeButton;
UIWindow* window;
CGFloat shrinkScale;
NSTimeInterval showAnimationTime;
NSTimeInterval hideAnimationTime;
BOOL isShown;
int direction;
id<HMSideDrawerDirectionalDelegate> _delegate;

@implementation HMSideDrawerDirectional

#pragma mark : accessors

+ (id<HMSideDrawerDirectionalDelegate>)delegate
{
    return _delegate;
}

+ (void)delegate:(id<HMSideDrawerDirectionalDelegate>)delegate
{
    _delegate = delegate;
}

#pragma mark : initialization

+ (void)initWithWindow:(UIWindow*)withWindow
       withViewController:(UIViewController*)withViewController
          withShrinkScale:(CGFloat)withShrinkScale
    withShowAnimationTime:(NSTimeInterval)withShowAnimationTime
    withHideAnimationTime:(NSTimeInterval)withHideAnimationTime
            withDirection:(int)withDirection
{
    window = withWindow;
    sideViewController = withViewController;
    shrinkScale = withShrinkScale;
    showAnimationTime = withShowAnimationTime;
    hideAnimationTime = withHideAnimationTime;
    direction = withDirection;
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
        CGSize windowSize = window.frame.size;
        [[self delegate] sideDrawerWillHideWithAnimationTime:hideAnimationTime];
        // remove the button
        [closeButton removeFromSuperview];
        [UIView animateWithDuration:hideAnimationTime animations:^{
            // move the view back to the main position
            currentViewController.view.center = CGPointMake(windowSize.width/2, windowSize.height/2); // animate half off the screen
            currentViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1); // grow back to full scale
        } completion:^(BOOL finished) {
            if (finished) {
                [sideViewController.view removeFromSuperview]; // remove the side view from the window
                currentViewController = nil; // stop holding onto the presented view
                [[self delegate] sideDrawerDidHide];
            }
        }];
        isShown = NO;
    }
}

+ (void)toggleMenuFromViewController:(UIViewController*)fromViewController
{
    // show sub view controller on the side
    if (!isShown) {
        CGSize windowSize = window.frame.size;
        [[self delegate] sideDrawerWillAppearWithAnimationTime:showAnimationTime];
        currentViewController = fromViewController; // hold onto the presented view to remove when hiding
        [window addSubview:sideViewController.view]; // add the side view
        [window bringSubviewToFront:currentViewController.view]; // bring the presented view on top
        [UIView animateWithDuration:showAnimationTime animations:^{
            // animate view to the side and resize
            switch (direction) {
                case SIDE_DRAWER_DIRECTION_RIGHT:
                    currentViewController.view.center = CGPointMake(windowSize.width, windowSize.height/2);
                    break;
                case SIDE_DRAWER_DIRECTION_LEFT:
                    currentViewController.view.center = CGPointMake(0, windowSize.height/2);
                    break;
                default:
                    break;
            }
            currentViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, shrinkScale, shrinkScale);
        } completion:^(BOOL finished) {
            if (finished) {
                // add button covering entire view so when tapped can return
                [self initCloseButtonToViewController:currentViewController];
                [window addSubview:closeButton];
                [[self delegate] sideDrawerDidAppear];
            }
        }];
        isShown = YES;
    } else {
        [self hideSideDrawer];
    }
}

+ (void)tapped:(id)sender
{
    [self hideSideDrawer];
}

@end
