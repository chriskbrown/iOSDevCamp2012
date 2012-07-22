//
//  CameraController.h
//  iosdevcamp2012
//
//  Created by Mark Burger on 7/21/12.
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

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Session.h"
#import "TextEntry.h"
#import "AppDelegate.h"

@interface CameraController : UIImagePickerController  <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

//- (void) launchCamera:(UIViewController *)controller;
- (NSString *) stringFromImage:(UIImage *)img;
-(void) saveText:(NSString *)text;


@end
