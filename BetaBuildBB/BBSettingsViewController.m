//
//  BBSettingsViewController.m
//  BetaBuildBB
//
//  Created by Viktor Falkner on 8/16/14.
//
//

#import "BBSettingsViewController.h"

@interface BBSettingsViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *facebookSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *twitterSwitch;

@end

@implementation BBSettingsViewController



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
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setTwitterSwitchState];
    [self setFacebookSwitchState];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) setFacebookSwitchState
{
    if (![PFFacebookUtils isLinkedWithUser:self.currentUser]) {
        [self.facebookSwitch setOn:NO];
    } else {
        [self.facebookSwitch setOn:YES];
    }
}

- (void) setTwitterSwitchState
{
    if (![PFTwitterUtils isLinkedWithUser:self.currentUser]) {
        [self.twitterSwitch setOn:NO];
    } else {
        [self.twitterSwitch setOn:YES];
    }
}
- (IBAction)facebookSwitch:(UISwitch *)sender {
    if (sender.on == YES) {
        [self linkFacebook];
    } else if (sender.on == NO) {
        [self unlinkFacebook];
    }
}

- (IBAction)twitterSwitch:(UISwitch *)sender {
    if (sender.on == YES) {
        [self linkTwitter];
    } else if (sender.on == NO) {
        [self unlinkTwitter];
    }
}
#pragma mark - Social Media Methods
- (void)linkTwitter
{
    if (![PFTwitterUtils isLinkedWithUser:self.currentUser]) {
        [PFTwitterUtils linkUser:self.currentUser block:^(BOOL succeeded, NSError *error) {
            if ([PFTwitterUtils isLinkedWithUser:self.currentUser]) {
                NSLog(@"Woohoo, user logged in with Twitter!");
            }
        }];
    }
}

- (void)linkFacebook
{
    if (![PFFacebookUtils isLinkedWithUser:self.currentUser]) {
        [PFFacebookUtils linkUser:self.currentUser permissions:nil block:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"Woohoo, user logged in with Facebook!");
            }
        }];
    }
}

- (void)unlinkTwitter
{
    [PFTwitterUtils unlinkUserInBackground:self.currentUser block:^(BOOL succeeded, NSError *error) {
        if (!error && succeeded) {
            NSLog(@"The user is no longer associated with their Twitter account.");
        }
    }];
}

- (void)unlinkFacebook
{
    [PFFacebookUtils unlinkUserInBackground:self.currentUser block:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"The user is no longer associated with their Facebook account.");
        }
    }];
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
