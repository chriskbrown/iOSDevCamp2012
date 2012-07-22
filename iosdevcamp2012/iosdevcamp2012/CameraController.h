//
//  CameraController.h
//  iosdevcamp2012
//
//  Created by Mark Burger on 7/21/12.
//  Copyright (c) 2012 Millennial Media. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraController : NSObject  <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

- (void) launchCamera:(UIViewController *)controller;
- (NSString *) stringFromImage:(UIImage *)img;
- (NSString *) applicationDocumentsDirectory;
@property (nonatomic, readonly) UIImagePickerController* ipc;

@end
