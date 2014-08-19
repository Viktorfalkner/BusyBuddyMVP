//
//  BBCoursePickerViewController.m
//  BetaBuildBB
//
//  Created by Marcus Smith on 8/16/14.
//
//

#import "BBCoursePickerViewController.h"
#import "BBCourse.h"
#import "BBDataStore.h"
#import "BBActivityPickerViewController.h"

@interface BBCoursePickerViewController ()

@property (weak, nonatomic) IBOutlet UIPickerView *classPicker;

- (IBAction)classesSelectedButton:(id)sender;

@end

@implementation BBCoursePickerViewController

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
    self.classPicker.dataSource = self;
    self.classPicker.delegate = self;
    self.dataStore = [BBDataStore sharedDataStore];
    [self.dataStore fetchCoursesForUniversityFromParse:^{
        NSLog(@"Courses retrieved");
        [self.classPicker reloadAllComponents];
    }];
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
    return [self.dataStore.universityCoursesArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    BBCourse *class = self.dataStore.universityCoursesArray[row];
    self.selectedCourse = self.dataStore.universityCoursesArray[row];
    return class.title;
}

#pragma mark -
#pragma mark PickerView Delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    self.selectedCourse = self.dataStore.universityCoursesArray[row];
}

#pragma mark - Navigation

//In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    BBActivityPickerViewController *nextVC = segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"classSelected"]) {
        nextVC.selectedUniversity = self.selectedUniversity;
        nextVC.selectedCourse = self.selectedCourse;
    }
}

- (IBAction)classesSelectedButton:(id)sender
{
    //Setting selected course to university
    //Later use a for loop to grab all the courses in the array of selected courses (once we implement that implementation)
    PFObject *studentCourseObject = [BBDataStore BBCourseToPFObject:self.selectedCourse];
    
    //Stick the objects in an array (more to come)
    NSArray *studentCoursesArray = @[studentCourseObject];
    
    //Store the course(s) for the current user and save updates
    PFUser *currentUser = [PFUser currentUser];
    [currentUser setObject:studentCoursesArray forKey:@"studentCourses"];
    [currentUser save];
}
@end