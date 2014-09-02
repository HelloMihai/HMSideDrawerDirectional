//
//  HMBasicAnimation.h
//  HMSideDrawerDirectionalExample
//
//  Created by Hello Mihai on 9/2/14.
//  Available under the MIT License. See the LICENSE file for more.
//

#import <Foundation/Foundation.h>

static NSString* const HMBasicAnimation_OPACITY       = @"opacity";
static NSString* const HMBasicAnimation_ROTATION_Y    = @"transform.rotation.y";
static NSString* const HMBasicAnimation_ROTATION_X    = @"transform.rotation.x";
static NSString* const HMBasicAnimation_ROTATION_Z    = @"transform.rotation.z";
static NSString* const HMBasicAnimation_SCALE_X       = @"transform.scale.x";
static NSString* const HMBasicAnimation_SCALE_Y       = @"transform.scale.y";
static NSString* const HMBasicAnimation_SCALE_Z       = @"transform.scale.z";
static NSString* const HMBasicAnimation_TRANSLATION_X = @"transform.translation.x";
static NSString* const HMBasicAnimation_TRANSLATION_Y = @"transform.translation.y";
static NSString* const HMBasicAnimation_TRANSLATION_Z = @"transform.translation.z";

@interface HMBasicAnimation : NSObject

+ (void)doRotate3DAnimation:(CALayer*)layer
              toDegreeAngle:(float)toDegreeAngle
                   duration:(CGFloat)duration
               delaySeconds:(CGFloat)delaySeconds
                    keyPath:(NSString*)keyPath;

+ (void)doAnimation:(CALayer*)layer
            toValue:(id)toValue
           duration:(CGFloat)duration
       delaySeconds:(CGFloat)delaySeconds
            keyPath:(NSString*)keyPath;

@end
