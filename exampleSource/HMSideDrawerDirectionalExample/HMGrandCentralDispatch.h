//
//  HMGrandCentralDispatch.h
//  HMSideDrawerDirectionalExample
//
//  Created by Hello Mihai on 9/2/14.
//  Available under the MIT License. See the LICENSE file for more.
//

#import <Foundation/Foundation.h>

@interface HMGrandCentralDispatch : NSObject

+ (void)delayCallbackOnMainQueueWithDelay:(double)delay block:(void (^)(void))block;
+ (void)delayCallbackDelay:(double)delay onQueue:(dispatch_queue_t)onQueue block:(void (^)(void))block;
+ (void)callOnMainQueue:(void (^)(void))block;

@end
