//
//  MainViewController.h
//  iosdevcamp2012
//
//  Created by Christopher Brown on 7/21/12.
//
//  Copyright 2012 Christopher Brown
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

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
