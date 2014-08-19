//
//  BBSubmitEmailViewController.h
//  BetaBuildBB
//
//  Created by Marcus Smith on 8/18/14.
//
//

#import <UIKit/UIKit.h>

@class BBDataStore;

@interface BBSubmitEmailViewController : UIViewController



@property (strong, nonatomic) BBDataStore *dataStore;

@property (strong, nonatomic) NSNumber *latitudeNumber;
@property (strong, nonatomic) NSNumber *longitudeNumber;


-(void)postUserEmailToParse;

@end