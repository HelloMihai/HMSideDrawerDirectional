//
//  Created by Hello Mihai on 8/19/14.
//  Available under the MIT License. See the LICENSE file for more.
//

#import "ViewController.h"
#import "HMSideDrawerDirectional.h"

@interface ViewController () <HMSideDrawerDirectionalDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)menuTapped:(id)sender
{
    [HMSideDrawerDirectional delegate:self];
    [HMSideDrawerDirectional toggleMenuFromViewController:self];
}

#pragma mark : side drawer delegate

-(void)sideDrawerWillAppearWithAnimationTime:(NSTimeInterval)animationTime
{
    NSLog(@"will appear %f", animationTime);
}
-(void)sideDrawerDidAppear
{
    NSLog(@"did appear");
}
-(void)sideDrawerWillHideWithAnimationTime:(NSTimeInterval)animationTime
{
    NSLog(@"will hide %f", animationTime);
}
-(void)sideDrawerDidHide
{
    NSLog(@"did hide");
}


@end
