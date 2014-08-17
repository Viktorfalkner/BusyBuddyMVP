//
//  BBCoursePickerViewController.h
//  BetaBuildBB
//
//  Created by Marcus Smith on 8/16/14.
//
//

#import <UIKit/UIKit.h>

@class BBDataStore;
@class BBUniversity;
@class BBCourse;

@interface BBCoursePickerViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) BBDataStore *dataStore;
@property (strong, nonatomic) BBUniversity *selectedUniversity;
@property (strong, nonatomic) BBCourse *selectedCourse;

@end
