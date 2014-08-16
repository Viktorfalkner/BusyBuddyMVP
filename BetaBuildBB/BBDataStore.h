//
//  BBDataStore.h
//  BetaBuildBB
//
//  Created by Viktor Falkner on 8/16/14.
//
//

#import <Foundation/Foundation.h>


@interface BBDataStore : NSObject

@property (strong, nonatomic) NSMutableArray *universitiesArray;
@property (strong, nonatomic) PFUser *currentUser;


+ (instancetype)sharedDataStore;
-(instancetype)init;
-(void)fetchUniversitiesFromParseWithCompletion:(void (^)(void))universitiesFetched;



@end
