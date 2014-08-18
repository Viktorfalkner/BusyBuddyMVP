//
//  BBUniversity.m
//  BetaBuildBB
//
//  Created by Viktor Falkner on 8/16/14.
//
//

#import "BBUniversity.h"

@implementation BBUniversity

- (instancetype)init
{
    return [self initWithObjectId:@"" WithName:@"" WithLocaiton:@""];
}


-(instancetype)initWithObjectId:(NSString *)initObjectId WithName:(NSString *)initName WithLocaiton:(NSString *)initLocation {
    self = [super init];
    if (self) {
        _objectId = initObjectId;
        _name = initName;
        _location = initLocation;
    }
    return self;
}

@end
