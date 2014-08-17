//
//  BBCreateMeetingNowViewController.h
//  BetaBuildBB
//
//  Created by Marcus Smith on 8/16/14.
//
//

#import <UIKit/UIKit.h>

@class BBUniversity;
@class BBCourse;

@interface BBCreateMeetingNowViewController : UIViewController

@property (strong, nonatomic) BBUniversity *selectedUniversity;
@property (strong, nonatomic) BBCourse *selectedCourse;
@property (strong, nonatomic) NSString *selectedActivity;

@end
