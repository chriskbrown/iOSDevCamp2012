//
//  FlipsideViewController.h
//  iosdevcamp2012
//
//  Created by Christopher Brown on 7/21/12.
//  Copyright (c) 2012 Millennial Media. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

@interface FlipsideViewController : UIViewController

@property (weak, nonatomic) IBOutlet id <FlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
