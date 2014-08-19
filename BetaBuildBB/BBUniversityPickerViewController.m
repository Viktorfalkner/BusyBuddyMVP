
//  BBUniversityPickerViewController.m
//  BetaBuildBB
//
//  Created by Viktor Falkner on 8/16/14.
//
//

#import "BBUniversityPickerViewController.h"
#import "BBDataStore.h"
#import "BBUniversity.h"
#import "BBCoursePickerViewController.h"
#import "BBLoginRootViewController.h"

@interface BBUniversityPickerViewController ()

@property (weak, nonatomic) IBOutlet UIPickerView *universityPicker;

- (IBAction)universityChosenButton:(id)sender;

@end

@implementation BBUniversityPickerViewController

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
    self.dataStore = [BBDataStore sharedDataStore];
    self.universityPicker.delegate = self;
    self.universityPicker.dataSource = self;


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
    return [self.dataStore.universitiesArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    BBUniversity *university = self.dataStore.universitiesArray[row];
    self.dataStore.selectedUniversity = self.dataStore.universitiesArray[row];
    return university.name;
}

#pragma mark -
#pragma mark PickerView Delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    self.dataStore.selectedUniversity = self.dataStore.universitiesArray[row];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
}

- (IBAction)universityChosenButton:(id)sender
{
    PFUser *currentUser = [PFUser currentUser];
    [currentUser setObject:self.dataStore.selectedUniversity.objectId forKey:@"universityPointer"];
    [currentUser setObject:[NSNumber numberWithBool:YES] forKey:@"pickedUniversity"];
    [currentUser saveInBackground];
}

@end