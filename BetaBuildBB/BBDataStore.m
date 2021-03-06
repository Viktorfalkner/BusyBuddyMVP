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
    //Is objectId property necessary for BBUniversity?
    userUniversity.objectId = universityToBeConverted.objectId;
    userUniversity[@"location"] = universityToBeConverted.location;
    
    return userUniversity;
}

//Fetch courses for University
-(void)fetchCoursesForUniversityFromParse:(void (^)(void))classesFetched
{
    PFUser *currentUser = [PFUser currentUser];
    PFQuery *queryClasses = [PFQuery queryWithClassName:@"Class"];
    [queryClasses whereKey:@"universityPointer" containsString:[currentUser[@"studentUniversity"] objectId]];
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

+(PFObject *)BBCourseToPFObject:(BBCourse *)courseToBeConverted
{
    PFObject *courseAtUniversity = [PFObject objectWithClassName:@"UserClasses"];
    
    courseAtUniversity[@"classTitle"] = courseToBeConverted.title;
    //Not sure if objectId property is necessary on BBCourse
//    courseAtUniversity.objectId = courseToBeConverted.objectId;
    courseAtUniversity[@"section"] = courseToBeConverted.section;
    courseAtUniversity[@"classProfessor"] = courseToBeConverted.professor;
    courseAtUniversity[@"department"] = courseToBeConverted.department;
    courseAtUniversity[@"subject"] = courseToBeConverted.subject;
    
    return courseAtUniversity;
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

+(BBUniversity *)parseStudentUniversityToBBUniversity
{
    PFUser *currentUser = [PFUser currentUser];
    
    //Check to attain all university data
    PFObject *currentStudentUniversityParse = [currentUser[@"studentUniversity"] fetchIfNeeded];
    
    BBUniversity *universityUpToDisplay = [[BBUniversity alloc] init];
    universityUpToDisplay.objectId = currentStudentUniversityParse.objectId;
    universityUpToDisplay.name = currentStudentUniversityParse[@"name"];
    universityUpToDisplay.location = currentStudentUniversityParse[@"location"];
    
    return universityUpToDisplay;
}

+(BBCourse *)parseStudentCourseToBBCourse
{
    //Fetch array of courses and iterate through
    PFUser *currentUser = [PFUser currentUser];
    NSArray *studentCoursesInParse = [currentUser objectForKey:@"studentCourses"];
    
    //Create and set properties for BBCourse object
    BBCourse *studentCourse = [[BBCourse alloc] init];
    
    //For now, only have to parse one object in Parse
    for (PFObject *studentCourseObject in studentCoursesInParse)
    {
        //Make sure all the data is attained properly
        [studentCourseObject fetchIfNeeded];
        //Just some of the properties
        studentCourse.title = studentCourseObject[@"classTitle"];
        studentCourse.professor = studentCourseObject[@"classProfessor"];
        studentCourse.objectId = studentCourseObject.objectId;
        studentCourse.section = studentCourseObject[@"section"];
    }

    //Later will return NSArray of BBCourses 
    return studentCourse;
}

@end
