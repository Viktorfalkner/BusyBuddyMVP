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

@interface BBCreateMeetingNowViewController ()

@property (weak, nonatomic) IBOutlet UILabel *universityLabel;
@property (weak, nonatomic) IBOutlet UILabel *courseLabel;
@property (weak, nonatomic) IBOutlet UITextField *meetupNameTextField;
- (IBAction)createMeeting:(id)sender;

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
    
    self.universityLabel.text = self.selectedUniversity.name;
    self.courseLabel.text = self.selectedCourse.title;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
