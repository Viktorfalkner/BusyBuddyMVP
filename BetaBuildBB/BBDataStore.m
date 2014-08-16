//
//  BBDataStore.m
//  BetaBuildBB
//
//  Created by Viktor Falkner on 8/16/14.
//
//

#import "BBDataStore.h"
#import "BBUniversity.h"

@implementation BBDataStore


- (instancetype)init
{
    self = [super init];
    if (self) {
        _universitiesArray = [NSMutableArray new];
    }
    return self;
}


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
-(NSMutableArray *)clearArray
{
    return [NSMutableArray new];
}



+ (instancetype)sharedDataStore {
    static BBDataStore *_sharedDataStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedDataStore = [[BBDataStore alloc]init];
    });
    
    return _sharedDataStore;
}

@end
