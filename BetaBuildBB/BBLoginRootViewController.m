//
//  BBLoginRootViewController.m
//  BetaBuildBB
//
//  Created by Troy Barrett on 7/5/14.
//
//

#import "BBLoginRootViewController.h"
#import "BBSettingsAndOptionsTableViewController.h"
#import "BBDataStore.h"
#import "BBMeetup.h"

@interface BBLoginRootViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapOutlet;
@property (weak, nonatomic) IBOutlet UITabBar *bottomTabBar;


@end

@implementation BBLoginRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - UIViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.bottomTabBar.delegate = self;
    
    self.dataStore = [BBDataStore sharedDataStore];
    
    
    //Tracking Location
    self.locationManager = [[CLLocationManager alloc]init];
    [self.locationManager startUpdatingLocation];
    self.currentLocation = [[CLLocation alloc]init];
    
    
    [self.dataStore fetchUniversitiesFromParseWithCompletion:^{
        NSLog(@"%@", self.dataStore.universitiesArray);
    }];
    
    //Set Map Delegate
    self.mapOutlet.delegate = self;
    self.mapOutlet.showsUserLocation = YES;
    
//    UIColor *busyBuddyYellow = [UIColor colorWithRed:254.0/255.0 green:197.0/255.0 blue:2.0/255.0 alpha:1];
    
     self.navigationController.navigationBar.tintColor = [UIColor yellowColor];
    
    //Color Dictionary
    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIColor yellowColor],NSForegroundColorAttributeName,
                                    [UIColor yellowColor],NSBackgroundColorAttributeName,nil];
    
    //Setting up Navigation Bar Colors
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:34.0/255 green:34.0/255.0 blue:34.0/255.0 alpha:1]];
    [[UINavigationBar appearance] setTitleTextAttributes:textAttributes];
   
    
    //Setting up Tab Bar colors
    [[UITabBar appearance] setBarTintColor:[UIColor colorWithRed:34.0/255 green:34.0/255.0 blue:34.0/255.0 alpha:1]];
    
    
   
    
    self.navigationController.navigationBar.titleTextAttributes = textAttributes;
    self.title = @"BusyBuddy";
    

    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //Left Drawer Button
    self.leftBarButtonItem = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(leftDrawerButtonPress:)];
    [self.leftBarButtonItem setMenuButtonColor:[UIColor yellowColor] forState:UIControlStateNormal];
    
    self.navigationItem.leftBarButtonItem  = self.leftBarButtonItem;
    
    //Right Drawer Button
    self.rightBarButtonItem = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(rightDrawerButtonPress:)];
    [self.rightBarButtonItem setMenuButtonColor:[UIColor yellowColor] forState:UIControlStateNormal];
    
    
    self.navigationItem.rightBarButtonItem  = self.rightBarButtonItem;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.currentUser = [PFUser currentUser];
    [self checkForLoggedInUser];

    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    self.currentLocation = locations.lastObject;
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    CLLocationCoordinate2D coord = self.mapOutlet.userLocation.location.coordinate;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 1500.0,1500.0);
    
    
    [self.mapOutlet setRegion:region animated:YES];
    
    
}

-(void)plotLocationsOnMap:(BBMeetup *)meetUpToBePlotted
{
    CGFloat latitudefloat = [meetUpToBePlotted.latitudeFloat floatValue];
    CGFloat longitudeFloat = [meetUpToBePlotted.latitudeFloat floatValue];
    
    MKPointAnnotation *pointToAnnotate = [[MKPointAnnotation alloc]init];
    
    pointToAnnotate.coordinate = CLLocationCoordinate2DMake(latitudefloat, longitudeFloat);
    pointToAnnotate.title = meetUpToBePlotted.meetupName;
    
    [self.mapOutlet addAnnotation:pointToAnnotate];

}


-(void)plotArrayOfMeetupsOnMap:(NSArray *)arrayToBePlotted
{
    for (BBMeetup *meetup in arrayToBePlotted) {
        [self plotLocationsOnMap:meetup];
    }
}



#pragma mark - STANDARD PARSE LOGIN METHODS
- (void) checkForLoggedInUser
{
    if (![PFUser currentUser]) {
        
        PFLogInViewController *logInViewController = [[PFLogInViewController alloc] init];
        logInViewController.delegate = self;
        logInViewController.facebookPermissions = [NSArray arrayWithObjects:@"email", nil];
        logInViewController.fields = PFLogInFieldsDefault | PFLogInFieldsTwitter | PFLogInFieldsFacebook | PFLogInFieldsDismissButton;
        
        PFSignUpViewController *signUpViewController = [[PFSignUpViewController alloc] init];
        signUpViewController.delegate = self;
        
        logInViewController.signUpController = signUpViewController;
        
        [self presentViewController:logInViewController animated:YES completion:NULL];
    } else {
        self.currentUser = [PFUser currentUser];
    }
}

#pragma mark - PFLoginViewControllerDelegate

// Sent to the delegate to determine whether the log in request should be submitted to the server.
- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password
{
    if (username && password && username.length != 0 && password.length != 0) {
        return YES; // Begin login process
    }
    
    [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                message:@"Make sure you fill out all of the information!"
                               delegate:nil
                      cancelButtonTitle:@"ok"
                      otherButtonTitles:nil] show];
    return NO; // Interrupt login process
}

// Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error
{
    NSLog(@"Failed to log in...");
}

// Sent to the delegate when the log in screen is dismissed.
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - PFSignUpViewControllerDelegate

// Sent to the delegate to determine whether the sign up request should be submitted to the server.
- (BOOL)signUpViewController:(PFSignUpViewController *)signUpController shouldBeginSignUp:(NSDictionary *)info
{
    BOOL informationComplete = YES;
    // loop through all of the submitted data
    for (id key in info) {
        NSString *field = [info objectForKey:key];
        if (!field || field.length == 0) { // check completion
            informationComplete = NO;
            break;
        }
    }
    // Display an alert if a field wasn't completed
    if (!informationComplete) {
        [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                    message:@"Make sure you fill out all of the information!"
                                   delegate:nil
                          cancelButtonTitle:@"ok"
                          otherButtonTitles:nil] show];
    }
    return informationComplete;
}

// Sent to the delegate when a PFUser is signed up.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user
{
    [self dismissViewControllerAnimated:YES completion:nil]; // Dismiss the PFSignUpViewController
}

// Sent to the delegate when the sign up attempt fails.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error
{
    NSLog(@"Failed to sign up...");
}

// Sent to the delegate when the sign up screen is dismissed.
- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController
{
    NSLog(@"User dismissed the signUpViewController");
}

#pragma mark - Left Button
-(void)leftDrawerButtonPress:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    
}

#pragma mark - Right Button
-(void)rightDrawerButtonPress:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"settingsSegue"]) {
        BBSettingsAndOptionsTableViewController *nextVC = segue.destinationViewController;
        
        nextVC.currentUser = self.currentUser;
        
    }
    
}
@end
