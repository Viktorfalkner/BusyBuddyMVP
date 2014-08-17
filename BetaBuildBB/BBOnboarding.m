//
//  BBOnboarding.m
//  BetaBuildBB
//
//  Created by Marcus Smith on 8/17/14.
//
//

#import "BBOnboarding.h"

@implementation BBOnboarding

+(void)firstTimeUserLogin
{
    UIAlertView *onboardingAlertView = [[UIAlertView alloc] initWithTitle:@"Choose Your University"
                                                                  message:@"Welcome!"
                                                                 delegate:self
                                                        cancelButtonTitle:@"Cancel"
                                                        otherButtonTitles:@"OK", nil];
    [onboardingAlertView show];
}

@end
