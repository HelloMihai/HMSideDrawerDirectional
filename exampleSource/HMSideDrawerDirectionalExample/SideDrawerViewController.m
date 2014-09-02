//
//  Created by Hello Mihai on 8/19/14.
//  Available under the MIT License. See the LICENSE file for more.
//

#import "SideDrawerViewController.h"
#import "HMSideDrawerDirectional.h"
#import "HMBasicAnimation.h"

@interface SideDrawerViewController () <HMSideDrawerDirectionalDelegate>
@property (strong, nonatomic) NSArray* buttons;
@property (strong, nonatomic) IBOutlet UIButton *buttonClose;
@property (strong, nonatomic) IBOutlet UIButton *button1;
@property (strong, nonatomic) IBOutlet UIButton *button2;
@property (strong, nonatomic) IBOutlet UIButton *button3;
@property (strong, nonatomic) IBOutlet UIButton *button4;
@property (strong, nonatomic) IBOutlet UIButton *button5;
@end

@implementation SideDrawerViewController

#pragma mark : accessors

- (NSArray*)buttons
{
    return @[self.buttonClose, self.button1, self.button2, self.button3, self.button4, self.button5];
}

#pragma mark : view controller life cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeTapped:(id)sender
{
    NSLog(@"hiding drawer from side menu");
    [HMSideDrawerDirectional hideSideDrawer];
}

- (IBAction)buttonTapped:(id)sender
{
    NSLog(@"button tapped");
}

#pragma mark : helpers

-(void) hideButtons
{
    for (UIButton* button in self.buttons) {
        button.alpha = 0;
    }
}

-(void) animateButtons
{
    float delay = 0;
    for (UIButton* button in self.buttons) {
        [HMBasicAnimation doAnimation:button.layer toValue:@(1) duration:0.5 delaySeconds:delay keyPath:HMBasicAnimation_OPACITY];
        delay += 0.1;
    }
}

#pragma mark : side drawer delegate

-(void)sideDrawerWillAppearWithAnimationTime:(NSTimeInterval)animationTime
{
    NSLog(@"will appear side drawer %f", animationTime);
    [self hideButtons];
}
-(void)sideDrawerDidAppear
{
    NSLog(@"did appear side drawer");
    [self animateButtons];
}
-(void)sideDrawerWillHideWithAnimationTime:(NSTimeInterval)animationTime
{
    NSLog(@"will hide side drawer %f", animationTime);
}
-(void)sideDrawerDidHide
{
    NSLog(@"did hide side drawer");
}

@end
