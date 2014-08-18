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
#import "BBUniversityPickerViewController.h"

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
    
    [self checkForLoggedInUser];
    
    //Left Drawer Button
    self.leftBarButtonItem = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(leftDrawerButtonPress:)];
    [self.leftBarButtonItem setMenuButtonColor:[UIColor yellowColor] forState:UIControlStateNormal];
    
    self.navigationItem.leftBarButtonItem  = self.leftBarButtonItem;
    
    //Right Drawer Button
    self.rightBarButtonItem = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(rightDrawerButtonPress:)];
    [self.rightBarButtonItem setMenuButtonColor:[UIColor yellowColor] forState:UIControlStateNormal];
    
    
    self.navigationItem.rightBarButtonItem  = self.rightBarButtonItem;
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
        self.dataStore.currentUser = [PFUser currentUser];
        [self checkIfUserSelectedUniversity];
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

- (void)checkIfUserSelectedUniversity
{
    if (![self.dataStore.currentUser[@"universityPointer"] boolValue])
    {
        BBUniversityPickerViewController *universityPickerVC = [self.storyboard instantiateViewControllerWithIdentifier:@"pickUniversityController"];
        
        [self.navigationController pushViewController:universityPickerVC animated:YES];
    }
}

// Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user
{
    self.dataStore.currentUser = user;
    [self checkIfUserSelectedUniversity];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// Sent to the delegate when a PFUser is signed up.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user
{
    [self checkIfUserSelectedUniversity];
    [self dismissViewControllerAnimated:YES completion:nil]; // Dismiss the PFSignUpViewController
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    BBSettingsAndOptionsTableViewController *nextVC = segue.destinationViewController;
    
        if ([segue.identifier isEqualToString:@"settingsSegue"]) {
            
            nextVC.currentUser = self.dataStore.currentUser;
            
        }

}

#pragma mark - Will make category with following methods

@end
