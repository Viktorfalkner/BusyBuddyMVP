//
//  BBUniversityPickerViewController.h
//  BetaBuildBB
//
//  Created by Viktor Falkner on 8/16/14.
//
//

#import <UIKit/UIKit.h>

@class BBUniversity;
@class BBDataStore;

@interface BBUniversityPickerViewController : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate>

@property (strong, nonatomic) BBUniversity *selectedUniversity;
@property (strong, nonatomic) BBDataStore *dataStore;

@end
