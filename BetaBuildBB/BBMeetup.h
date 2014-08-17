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



@property (nonatomic) NSNumber *latitudeFloat;
@property (nonatomic) NSNumber *longitudeFloat;

//User Input Properties
@property (strong, nonatomic) NSString *meetupName;
@property (strong, nonatomic) NSString *meetupActivity;


//Relational Properties
@property (strong, nonatomic) BBUniversity *meetupUniversity;
@property (strong, nonatomic) BBCourse *meetupCourse;






@end
