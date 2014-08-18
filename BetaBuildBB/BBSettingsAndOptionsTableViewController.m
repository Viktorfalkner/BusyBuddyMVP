//
//  BBSettingsAndOptionsTableViewController.m
//  BetaBuildBB
//
//  Created by Viktor Falkner on 8/17/14.
//
//

#import "BBSettingsAndOptionsTableViewController.h"
#import "BBLoginRootViewController.h"

@interface BBSettingsAndOptionsTableViewController ()

@property (weak, nonatomic) IBOutlet UISwitch *facebookSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *twitterSwitch;

@end

@implementation BBSettingsAndOptionsTableViewController




- (IBAction)logoutButton:(id)sender
{
    [PFUser logOut];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

//    [self.tableView setBackgroundColor:[UIColor colorWithRed:34.0/255 green:34.0/255.0 blue:34.0/255.0 alpha:1]];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setTwitterSwitchState];
    [self setFacebookSwitchState];
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
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
