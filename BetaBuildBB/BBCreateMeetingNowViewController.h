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
@class BBDataStore;

@interface BBCreateMeetingNowViewController : UIViewController <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) BBDataStore *dataStore;

@property (strong, nonatomic) BBUniversity *selectedUniversity;
@property (strong, nonatomic) BBCourse *selectedCourse;
@property (strong, nonatomic) NSString *selectedActivity;

@end
