//
//  BBCourse.h
//  BetaBuildBB
//
//  Created by Marcus Smith on 8/16/14.
//
//

#import <Foundation/Foundation.h>

@interface BBCourse : NSObject

@property (strong, nonatomic) NSString *objectId;
@property (strong, nonatomic) NSString *universityPointer;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *professor;
@property (strong, nonatomic) NSNumber *callNumber;
@property (strong, nonatomic) NSString *department;
@property (strong, nonatomic) NSString *subject;
@property (strong, nonatomic) NSString *classNumber;
@property (strong, nonatomic) NSString *section;
@property (strong, nonatomic) NSDate *startDate;
@property (strong, nonatomic) NSDate *endDate;
@property (strong, nonatomic) NSArray *classDays;

- (instancetype)initWithUniversityPointer:(NSString *)initUniversityPointer
                                WithTitle:(NSString *)initTitle
                            WithProfessor:(NSString *)initProfessor
                           WithCallNumber:(NSNumber *)initCallNumber
                           WithDepartment:(NSString *)initDepartment
                              WithSubject:(NSString *)initSubject
                          WithClassNumber:(NSString *)initClassNumber
                        WithSectionNumber:(NSString *)initSectionNumber
                            WithStartDate:(NSDate *)initStartDate
                              WithEndDate:(NSDate *)initEndDate
                            WithClassDays:(NSArray *)initClassDays;

-(instancetype)initFromDictionary:(NSDictionary *)initDictionary;

@end
