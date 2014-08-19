//
//  BBSubmitEmailViewController.m
//  BetaBuildBB
//
//  Created by Marcus Smith on 8/18/14.
//
//

#import "BBSubmitEmailViewController.h"
#import "BBMeetup.h"

@interface BBSubmitEmailViewController ()

@property (weak, nonatomic) IBOutlet UITextField *submitEmailTextField;

- (IBAction)donePressed:(id)sender;

@end

@implementation BBSubmitEmailViewController

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
    

    
    [self.submitEmailTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)postUserEmailToParse
{
    PFUser *currentUser = [PFUser currentUser];
    
    [currentUser setObject:self.submitEmailTextField.text forKey:@"email"];
    
    [currentUser save];
}

- (IBAction)donePressed:(id)sender
{
    
    [self postUserEmailToParse];

//    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end