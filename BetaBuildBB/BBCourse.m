//
//  BBCourse.m
//  BetaBuildBB
//
//  Created by Marcus Smith on 8/16/14.
//
//

#import "BBCourse.h"

@implementation BBCourse

- (instancetype)init
{
return [self initWithUniversityPointer:@""
                             WithTitle:@"Aint no classes in here sir/ma'am"
                         WithProfessor:@""
                        WithCallNumber:@0
                        WithDepartment:@""
                           WithSubject:@""
                       WithClassNumber:@""
                     WithSectionNumber:@""
                         WithStartDate:[NSDate date]
                           WithEndDate:[NSDate date]
                         WithClassDays:@[ @"" ]];
}

-(instancetype)initFromDictionary:(NSDictionary *)initDictionary {
    NSString *universityPointer = initDictionary[@"universityPointer"];
    NSString *title = initDictionary[@"classTitle"];
    NSString *classProfessor = initDictionary[@"classProfessor"];
    NSNumber *callNumber = initDictionary[@"callNumber"];
    NSString *department = initDictionary[@"department"];
    NSString *subject = initDictionary[@"subject"];
    NSString *classNumber = initDictionary[@"classNumber"];
    NSString *section = initDictionary[@"section"];
    NSArray *classDays = initDictionary[@"classDays"];
    NSDate *startDate = initDictionary[@"startDate"];
    NSDate *endDate = initDictionary[@"endDate"];
    
return [self initWithUniversityPointer:universityPointer
                             WithTitle:title
                         WithProfessor:classProfessor
                        WithCallNumber:callNumber
                        WithDepartment:department
                           WithSubject:subject
                       WithClassNumber:classNumber
                     WithSectionNumber:section
                         WithStartDate:startDate
                           WithEndDate:endDate
                         WithClassDays:classDays];
    
}

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
                            WithClassDays:(NSArray *)initClassDays {
    self = [super init];
    if (self) {
        _universityPointer = initUniversityPointer;
        _title = initTitle;
        _professor = initProfessor;
        _callNumber = initCallNumber;
        _department = initDepartment;
        _subject = initSubject;
        _classNumber = initClassNumber;
        _section = initSectionNumber;
        _startDate = initStartDate;
        _endDate = initEndDate;
        _classDays = initClassDays;
    }
    return self;
}

@end
