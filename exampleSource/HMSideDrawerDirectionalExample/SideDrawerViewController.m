//
//  Created by Hello Mihai on 8/19/14.
//  Available under the MIT License. See the LICENSE file for more.
//

#import "SideDrawerViewController.h"
#import "HMSideDrawerDirectional.h"

@interface SideDrawerViewController ()

@end

@implementation SideDrawerViewController

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
