//
//  CameraController.h
//  iosdevcamp2012
//
//  Created by Mark Burger on 7/21/12.
//

#import <UIKit/UIKit.h>

@interface CameraController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

- (NSString *) stringFromImage:(UIImage *)img;
- (NSString *) applicationDocumentsDirectory;

@end
