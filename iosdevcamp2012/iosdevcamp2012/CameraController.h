//
//  CameraController.h
//  iosdevcamp2012
//
//  Created by Mark Burger on 7/21/12.
//

#import <UIKit/UIKit.h>

@interface CameraController : UIImagePickerController  <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic) NSString* dataPath;

- (void) launchCamera:(UIViewController *)controller;
- (NSString *) stringFromImage:(UIImage *)img;



@end
