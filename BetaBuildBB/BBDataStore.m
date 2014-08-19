//
//  BBDataStore.m
//  BetaBuildBB
//
//  Created by Viktor Falkner on 8/16/14.
//
//

#import "BBDataStore.h"
#import "BBUniversity.h"
#import "BBCourse.h"
#import "BBMeetup.h"

@implementation BBDataStore

+ (instancetype)sharedDataStore {
    static BBDataStore *_sharedDataStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedDataStore = [[BBDataStore alloc]init];
    });
    
    return _sharedDataStore;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _universitiesArray = [NSMutableArray new];
        _universityCoursesArray = [NSMutableArray new];
    }
    return self;
}

-(NSMutableArray *)clearArray
{
    return [NSMutableArray new];
}

//Fetch universities
-(void)fetchUniversitiesFromParseWithCompletion:(void (^)(void))universitiesFetched {
    PFQuery *queryUniversities = [PFQuery queryWithClassName:@"University"];
    self.universitiesArray = [self clearArray];
    [queryUniversities findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error)
        {
            for (PFObject *university in objects)
            {
                NSString *name = university[@"name"];
                NSString *location = university[@"location"];
                NSString *objectId = university.objectId;
                
                BBUniversity *newUni = [[BBUniversity alloc]initWithObjectId:objectId WithName:name WithLocaiton:location];
                
                [self.universitiesArray addObject:newUni];
            }
            universitiesFetched();
        }
        else
        {
            NSLog(@"Parse error in datastore: %@", error.localizedDescription);
        }
    }];
    
}

+(PFObject *)BBUniversityToPFObject:(BBUniversity *)universityToBeConverted
{
    PFObject *userUniversity = [PFObject objectWithClassName:@"University"];
    
    userUniversity[@"name"] = universityToBeConverted.name;
    userUniversity[@"objectId"] = universityToBeConverted.objectId;
    userUniversity[@"location"] = universityToBeConverted.location;
    
    return userUniversity;
}

//Fetch courses for University
-(void)fetchCoursesForUniversityFromParse:(void (^)(void))classesFetched
{
    PFQuery *queryClasses = [PFQuery queryWithClassName:@"Class"];
    [queryClasses whereKey:@"universityPointer" containsString:self.selectedUniversity.objectId];
    self.universityCoursesArray = [self clearArray];
    [queryClasses findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error)
        {
            if ([objects count] == 0)
            {
                BBCourse *emptyCourse = [[BBCourse alloc] init];
                [self.universityCoursesArray addObject:emptyCourse];
            }
            else
            {
                for (NSDictionary *class in objects)
                {
                    BBCourse *newCourse = [[BBCourse alloc]initFromDictionary:class];
                    [self.universityCoursesArray addObject:newCourse];
                }
            }
            classesFetched();
        }
        else
        {
            NSLog(@"Parse error in datastore: %@", error.localizedDescription);
        }
    }];
    
}

-(void)sendBBMeetupToParse:(BBMeetup *)newMeetup
{
    PFObject *meetupToStore = [PFObject objectWithClassName:@"BBMeetup"];
    
    PFUser *currentUser = [PFUser currentUser];
    
    
//    meetupToStore[@"classPointer"] = newMeetup.blank
    
    meetupToStore[@"meetingName"] = newMeetup.meetingName;
//    meetupToStore[@"nameOfClass"] = newMeetup.nameOfClass;
    meetupToStore[@"latitudeValue"] = newMeetup.latitudeNumber ;
    meetupToStore[@"longitudeValue"] = newMeetup.longitudeNumber;
    meetupToStore[@"locationName"] = newMeetup.locationName;
    meetupToStore[@"userPointer"] = currentUser.objectId;
    meetupToStore[@"activityType"] = newMeetup.activityType;
    
    meetupToStore[@"beginningTime"] = [NSDate date];
    
    meetupToStore[@"endTime"] = [[NSDate date] dateByAddingTimeInterval:60*60];
    
    meetupToStore[@"locationName"] = newMeetup.locationName;
    meetupToStore[@"studentUniversity"] = newMeetup.studentUniversity;

    [meetupToStore saveInBackground];
    
}

@end
