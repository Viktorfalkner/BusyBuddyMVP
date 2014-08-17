//
//  BBActivityPickerViewController.h
//  BetaBuildBB
//
//  Created by Marcus Smith on 8/16/14.
//
//

#import <UIKit/UIKit.h>

@class BBCourse;
@class BBUniversity;

@interface BBActivityPickerViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) BBCourse *selectedCourse;
@property (strong, nonatomic) BBUniversity *selectedUniversity;
@property (strong, nonatomic) NSString *selectedActivity;
@property (strong, nonatomic) NSArray *meetupActivities;

@end
