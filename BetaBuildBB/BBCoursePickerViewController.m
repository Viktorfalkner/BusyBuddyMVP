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

@end