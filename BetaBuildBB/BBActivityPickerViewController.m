//
//  BBActivityPickerViewController.m
//  BetaBuildBB
//
//  Created by Marcus Smith on 8/16/14.
//
//

#import "BBActivityPickerViewController.h"
#import "BBCreateMeetingNowViewController.h"

@interface BBActivityPickerViewController ()

@property (weak, nonatomic) IBOutlet UIPickerView *activityPicker;

@end

@implementation BBActivityPickerViewController

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
    self.meetupActivities = @[@"Homework", @"Mid-Term", @"Final", @"Review"];
    self.activityPicker.dataSource = self;
    self.activityPicker.delegate = self;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return [self.meetupActivities count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return self.meetupActivities[row];
}

#pragma mark -
#pragma mark PickerView Delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    self.selectedActivity = self.meetupActivities[row];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    BBCreateMeetingNowViewController *nextVC = segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"activitySelected"]) {
        nextVC.selectedUniversity = self.selectedUniversity;
        nextVC.selectedCourse = self.selectedCourse;
        nextVC.selectedActivity = self.selectedActivity;
    }
}

@end