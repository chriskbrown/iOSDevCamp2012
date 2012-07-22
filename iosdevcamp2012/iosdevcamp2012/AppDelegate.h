//
//  AppDelegate.h
//  iosdevcamp2012
//
//  Created by Christopher Brown on 7/21/12.
//

#import <UIKit/UIKit.h>
#define kMyClientID @"3a994803e36ab46763714a79719ca26b"
#define kMyClientSecret @"3a994803e36ab46763714a79719ca26b"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
