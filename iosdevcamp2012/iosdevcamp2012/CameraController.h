//
//  CameraController.h
//  iosdevcamp2012
//
//  Created by Mark Burger on 7/21/12.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface CameraController : UIImagePickerController  <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

//- (void) launchCamera:(UIViewController *)controller;
- (NSString *) stringFromImage:(UIImage *)img;



@end
