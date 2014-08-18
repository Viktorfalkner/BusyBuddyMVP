//
//  BBUniversity.h
//  BetaBuildBB
//
//  Created by Viktor Falkner on 8/16/14.
//
//

#import <Foundation/Foundation.h>

@interface BBUniversity : NSObject

@property (strong, nonatomic) NSString *objectId;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *location;

-(instancetype)initWithObjectId:(NSString *)initObjectId
                       WithName:(NSString *)initName
                   WithLocaiton:(NSString *)initLocation;

@end
