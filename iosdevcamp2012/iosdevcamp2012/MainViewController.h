//
//  MainViewController.h
//  iosdevcamp2012
//
//  Created by Christopher Brown on 7/21/12.
//  Copyright (c) 2012 Millennial Media. All rights reserved.
//

#import "FlipsideViewController.h"

#import <CoreData/CoreData.h>

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
