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

@property (strong, nonatomic) BBDataStore *dataStore;

//User selected university
@property (strong, nonatomic) BBUniversity *selectedUniversity;

@end
