//
//  BBCreateMeetingNowViewController.m
//  BetaBuildBB
//
//  Created by Marcus Smith on 8/16/14.
//
//

#import "BBCreateMeetingNowViewController.h"
#import "BBUniversity.h"
#import "BBCourse.h"
#import "BBMeetup.h"
#import "BBDataStore.h"

@interface BBCreateMeetingNowViewController ()

@property (weak, nonatomic) IBOutlet UILabel *universityLabel;
@property (weak, nonatomic) IBOutlet UILabel *courseLabel;
@property (weak, nonatomic) IBOutlet UITextField *meetupNameTextField;
- (IBAction)createMeeting:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *locationNameTextField;

@end

@implementation BBCreateMeetingNowViewController

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
    
    
    self.locationManager.delegate = self;
    
    self.locationManager = [[CLLocationManager alloc]init];
    
    [self.locationManager startUpdatingLocation];
    
    self.dataStore = [BBDataStore sharedDataStore];
    
    self.universityLabel.text = self.selectedUniversity.name;
    self.courseLabel.text = self.selectedCourse.title;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)makeMeetupWithCompletionBlock:(void(^)(void))completionBlock {
    // [self.datastore wrapMeetup and Save To Parse]
    
    
    BBMeetup *meetupToStore = [[BBMeetup alloc]init];
    PFUser *currentUser = [PFUser currentUser];
    
    meetupToStore.latitudeNumber = [NSNumber numberWithFloat:self.locationManager.location.coordinate.latitude];
    meetupToStore.longitudeNumber = [NSNumber numberWithFloat:self.locationManager.location.coordinate.longitude];
    
    meetupToStore.meetingName = self.meetupNameTextField.text;
    meetupToStore.activityType = self.selectedActivity;
    
    meetupToStore.beginningTime = [NSDate date];
    meetupToStore.endTime = [NSDate date];
    
    meetupToStore.locationName = self.locationNameTextField.text;
    meetupToStore.userPointer = currentUser.objectId;
    meetupToStore.nameOfClass = self.courseLabel.text;
    
    [BBDataStore sendBBMeetupToParse:meetupToStore];
    completionBlock();
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

- (IBAction)createMeeting:(id)sender {
    
    [self makeMeetupWithCompletionBlock:^{
        //[self.locationManager stopUpdatingLocation];
    }];
    

    [self.navigationController popToRootViewControllerAnimated:YES];



}
@end
