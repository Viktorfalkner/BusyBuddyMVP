//
//  BBMeetup.h
//  BetaBuildBB
//
//  Created by Viktor Falkner on 8/16/14.
//
//

#import <Foundation/Foundation.h>

@class BBUniversity;
@class BBCourse;

@interface BBMeetup : NSObject



@property (nonatomic) NSNumber *latitudeNumber;
@property (nonatomic) NSNumber *longitudeNumber;

//User Input Properties
@property (strong, nonatomic) NSString *meetupName;
@property (strong, nonatomic) NSString *activityType;
@property (strong, nonatomic) NSDate *beginningTime;
@property (strong, nonatomic) NSDate *endTime;

@property (strong, nonatomic) NSString *locationName;
@property (strong, nonatomic) NSString *meetingName;
@property (strong, nonatomic) NSString *nameOfClass;
@property (strong, nonatomic) NSString *userPointer;

//Relational Properties
@property (strong, nonatomic) BBUniversity *meetupUniversity;
@property (strong, nonatomic) BBCourse *meetupCourse;






@end
