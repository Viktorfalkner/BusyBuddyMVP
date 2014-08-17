//
//  BBLoginRootViewController.h
//  BetaBuildBB
//
//  Created by Troy Barrett on 7/5/14.
//
//

#import <UIKit/UIKit.h>
#import "UIViewController+MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
@class BBDataStore;

@interface BBLoginRootViewController : UIViewController <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate, UITabBarDelegate, MKMapViewDelegate, CLLocationManagerDelegate>


@property (strong, nonatomic) PFUser *currentUser;

@property (strong, nonatomic) BBDataStore *dataStore;

@property (strong, nonatomic) MMDrawerBarButtonItem *leftBarButtonItem;
@property (strong, nonatomic) MMDrawerBarButtonItem *rightBarButtonItem;


@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *currentLocation;


@end
