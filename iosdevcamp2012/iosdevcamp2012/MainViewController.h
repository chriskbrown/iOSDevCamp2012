//
//  MainViewController.h
//  iosdevcamp2012
//
//  Created by Christopher Brown on 7/21/12.
//

#import "FlipsideViewController.h"
#import "TextTableViewController.h"
#import "CameraController.h"
#import "GTMHTTPFetcher.h"
#import "GTMOAuth2ViewControllerTouch.h"
#import <CoreData/CoreData.h>

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) CameraController *ipc;

- (GTMOAuth2Authentication *)singlyAuth;
- (void)authorize:(NSString *)service;
- (IBAction)authorizeWithTwitter;

@end
