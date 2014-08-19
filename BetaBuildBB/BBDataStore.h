//
//  BBDataStore.h
//  BetaBuildBB
//
//  Created by Viktor Falkner on 8/16/14.
//
//

#import <Foundation/Foundation.h>

@class BBUniversity;
@class BBMeetup;
@class BBUser;
@class BBCourse;

@interface BBDataStore : NSObject

@property (strong, nonatomic) NSMutableArray *universitiesArray;
@property (strong, nonatomic) PFUser *currentUser;
@property (strong, nonatomic) NSMutableArray *universityCoursesArray;
@property (strong, nonatomic) BBUniversity *selectedUniversity;

@property (strong, nonatomic) NSMutableArray *allMeetUpsArray;
@property (strong, nonatomic) BBMeetup *currentUserMeetup;

-(void)sendBBMeetupToParse:(BBMeetup *)newMeetup;

+(instancetype)sharedDataStore;
-(instancetype)init;
-(void)fetchUniversitiesFromParseWithCompletion:(void (^)(void))universitiesFetched;
-(void)fetchCoursesForUniversityFromParse:(void (^)(void))classesFetched;

//Conversion methods 
+(PFObject *)BBUniversityToPFObject:(BBUniversity *)universityToBeConverted;
+(PFObject *)BBCourseToPFObject:(BBCourse *)courseToBeConverted;

@end
