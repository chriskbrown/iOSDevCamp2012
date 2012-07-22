//
//  MainViewController.h
//  iosdevcamp2012
//
//  Created by Christopher Brown on 7/21/12.
//

#import "FlipsideViewController.h"

#import <CoreData/CoreData.h>

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
