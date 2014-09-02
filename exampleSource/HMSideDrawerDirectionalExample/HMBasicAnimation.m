//
//  HMBasicAnimation.m
//  HMSideDrawerDirectionalExample
//
//  Created by Hello Mihai on 9/2/14.
//  Available under the MIT License. See the LICENSE file for more.
//

#import "HMBasicAnimation.h"
#import "HMGrandCentralDispatch.h"

@implementation HMBasicAnimation

+ (void)doAnimation:(CALayer*)layer
            toValue:(id)toValue
           duration:(CGFloat)duration
       delaySeconds:(CGFloat)delaySeconds
            keyPath:(NSString*)keyPath
{
    id currentValue             = [layer valueForKeyPath:keyPath];
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:keyPath];
    animation.fromValue         = currentValue;
    animation.toValue           = toValue;
    animation.duration          = duration;
    animation.beginTime         = CACurrentMediaTime() + delaySeconds;
    [layer addAnimation:animation forKey:keyPath]; // start animation
    
    // on delay set the value to the model (animating presentation layer wont update model)
    [HMGrandCentralDispatch delayCallbackOnMainQueueWithDelay:delaySeconds block:^{
        [layer setValue:toValue forKeyPath:keyPath];
    }];
}

+ (void)doRotate3DAnimation:(CALayer*)layer
              toDegreeAngle:(float)toDegreeAngle
                   duration:(CGFloat)duration
               delaySeconds:(CGFloat)delaySeconds
                    keyPath:(NSString*)keyPath
{
    CATransform3D transform = CATransform3DIdentity;
    transform.m34           = 1.0 / 500.0;
    layer.transform         = transform;
    
    float radian = [self degreeToRadian:toDegreeAngle];
    [self doAnimation:layer toValue:@(radian) duration:duration delaySeconds:delaySeconds keyPath:keyPath];
}

#pragma mark : helpers

+ (float)degreeToRadian:(float)degrees
{
    return degrees * M_PI / 180;
}

@end
