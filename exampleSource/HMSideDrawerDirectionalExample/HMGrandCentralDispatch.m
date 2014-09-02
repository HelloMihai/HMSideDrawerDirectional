//
//  HMGrandCentralDispatch.m
//  HMSideDrawerDirectionalExample
//
//  Created by Hello Mihai on 9/2/14.
//  Available under the MIT License. See the LICENSE file for more.
//

#import "HMGrandCentralDispatch.h"

@implementation HMGrandCentralDispatch

+ (void)delayCallbackOnMainQueueWithDelay:(double)delay block:(void (^)(void))block
{
    [self delayCallbackDelay:delay onQueue:dispatch_get_main_queue() block:block];
}

+ (void)delayCallbackDelay:(double)delay onQueue:(dispatch_queue_t)onQueue block:(void (^)(void))block
{
    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC);
    dispatch_after(when, onQueue, ^(void) {
        if (block)
            block();
    });
}

+ (void)callOnMainQueue:(void (^)(void))block
{
    dispatch_async(dispatch_get_main_queue(), block);
}

@end
