//
//  BBDataStore.h
//  BetaBuildBB
//
//  Created by Viktor Falkner on 8/16/14.
//
//

#import <Foundation/Foundation.h>

@class BBUniversity;

@interface BBDataStore : NSObject

@property (strong, nonatomic) NSMutableArray *universitiesArray;
@property (strong, nonatomic) NSMutableArray *universityCoursesArray;
@property (strong, nonatomic) PFUser *currentUser;


+(instancetype)sharedDataStore;
-(instancetype)init;
-(void)fetchUniversitiesFromParseWithCompletion:(void (^)(void))universitiesFetched;
-(void)fetchCoursesForUniversity:(BBUniversity *)university
                       FromParse:(void (^)(void))classesFetched;

@end
