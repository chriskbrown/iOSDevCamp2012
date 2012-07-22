//
//  MainViewController.m
//  iosdevcamp2012
//
//  Created by Christopher Brown on 7/21/12.
//

#import "MainViewController.h"
#import "CameraController.h"
#import "AppDelegate.h"


@implementation MainViewController



@synthesize managedObjectContext = _managedObjectContext;
@synthesize ipc;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - Event handling

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) 
    {
        if ([UIImagePickerController isSourceTypeAvailable:
             UIImagePickerControllerSourceTypeCamera] == NO) {
            NSLog( @"No camera!" );
            return;
        }
        
        ipc = [CameraController new];
        [ipc setSourceType:UIImagePickerControllerCameraCaptureModeVideo];
        [ipc setDelegate:ipc];
        [self presentModalViewController:ipc animated:YES];
        
    } 
    else if (buttonIndex == 1) 
    {
        ipc = [CameraController new];
        [ipc setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [ipc setDelegate:ipc];

        [self presentModalViewController:ipc animated:YES];

    } 
}  




- (IBAction)capturePressed:(id) sender {
//    CameraController *cc = [CameraController new];
//    [cc launchCamera:self];
    
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Choose an image source" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera", @"Photo Library",nil];
    
    [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];

    //[actionSheet showInView:self.parentViewController.view];
    
    [actionSheet showInView:self.view];
    
    
//        if ([UIImagePickerController isSourceTypeAvailable:
//             UIImagePickerControllerSourceTypeCamera] == NO) {
//            NSLog( @"No camera!" );
//            return;
//        }
//        
//        ipc = [UIImagePickerController new];
//        [ipc setSourceType:UIImagePickerControllerCameraCaptureModeVideo];
//        [ipc setDelegate:self];
//        [self presentModalViewController:ipc animated:YES];

}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSManagedObject *sessionInfo = [NSEntityDescription
                                    insertNewObjectForEntityForName:@"Session"
                                    inManagedObjectContext:self.managedObjectContext];

//    NSManagedObject *textEntryInfo = [NSEntityDescription
//                                          insertNewObjectForEntityForName:@"TextEntry"
//                                          inManagedObjectContext:self.managedObjectContext];
    
    NSString *locDescription = [[NSString alloc] initWithString:@"This is a description of a location"];
    [sessionInfo setValue:locDescription forKey:@"location"];
    
    NSString *body = [[NSString alloc] initWithString:@"This is some text"];
    [sessionInfo setValue:body forKey:@"text"];
   
    [sessionInfo setValue:[NSDate date] forKey:@"begintime"];
    

    
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    //List all the objects in the db
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *sessionEntity = [NSEntityDescription
                                          entityForName:@"Session" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:sessionEntity];
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    
    
    for (NSManagedObject *sessionObject in fetchedObjects) {
        NSLog(@"Latitude: %@", [sessionObject valueForKey:@"latitude"]);
        NSLog(@"Longitude: %@", [sessionObject valueForKey:@"longitude"]);
        NSLog(@"Location: %@", [sessionObject valueForKey:@"location"]);
        NSLog(@"Timestamp: %@", [sessionObject valueForKey:@"begintime"]);
        NSLog(@"Text body: %@", [sessionObject valueForKey:@"text"]);
    }
    
//    NSEntityDescription *textEntryEntity = [NSEntityDescription
//                                          entityForName:@"TextEntry" inManagedObjectContext:self.managedObjectContext];
//    [fetchRequest setEntity:textEntryEntity];
//    NSArray *fetchedObjects2 = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
//    
//    for (NSManagedObject *textEntryObject in fetchedObjects2) {
//        NSLog(@"Text body: %@", [textEntryObject valueForKey:@"body"]);
//    }
//    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    NSError *error;
//    
//    NSManagedObject *sessionInfo = [NSEntityDescription
//                                    insertNewObjectForEntityForName:@"Session"
//                                    inManagedObjectContext:self.managedObjectContext];
//    //[sessionInfo setValue:NSNumber forKey:@"latitude"];
//    
//    NSManagedObject *textEntryInfo = [NSEntityDescription
//                                      insertNewObjectForEntityForName:@"TextEntry"
//                                      inManagedObjectContext:self.managedObjectContext];
    
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    NSLog(@"Segue!!!!!!!");
    
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
    }
    
//    if ([[segue identifier] isEqualToString:@"CameraSeque"]) {
//        [[segue destinationViewController] setDelegate:self];
//    }
    NSLog(@"controllerProgram:: prepareForSegue: %@", segue.identifier );
    
    if ([[segue identifier] isEqualToString:@"showTextTable"]) {
        
        NSLog(@"Segue ident" );
               
        //[[segue destinationViewController] setDelegate:self];
        
//        UINavigationController *nv = (UINavigationController *)[segue destinationViewController];
//        [nv setDelegate:self];
        TextTableViewController *ttvc = (TextTableViewController *)[segue destinationViewController];
        ttvc.managedObjectContext = self.managedObjectContext;
        //[ttvc setDelegate:self];
    }
}

#pragma mark - Singly methods

- (GTMOAuth2Authentication *)singlyAuth
{
    
    // Set the token URL to the Singly token endpoint.
    NSURL *tokenURL = [NSURL URLWithString:@"https://api.singly.com/oauth/access_token"];
    
    // Set a bogus redirect URI. It won't actually be used as the redirect will
    // be intercepted by the OAuth library and handled in the app.
    NSString *redirectURI = @"http://api.singly.com/OAuthCallback";
    
    GTMOAuth2Authentication *auth;
    auth = [GTMOAuth2Authentication authenticationWithServiceProvider:@"Singly API"
                                                             tokenURL:tokenURL
                                                          redirectURI:redirectURI
                                                             clientID:kMyClientID
                                                         clientSecret:kMyClientSecret];
    
    // The Singly API does not return a token type, therefore we set one here to
    // avoid a warning being thrown.
    [auth setTokenType:@"Bearer"];
    
    return auth;
}



- (void)authorize:(NSString *)service
{
    GTMOAuth2Authentication *auth = [self singlyAuth];
    
    // Prepare the Authorization URL. We will pass in the name of the service
    // that we wish to authorize with.
    NSURL *authURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.singly.com/oauth/authorize?service=%@", service]];
    
    // Display the authentication view
    GTMOAuth2ViewControllerTouch *viewController;
    viewController = [ [GTMOAuth2ViewControllerTouch alloc] initWithAuthentication:auth
                                                                  authorizationURL:authURL
                                                                  keychainItemName:nil
                                                                          delegate:self
                                                                  finishedSelector:@selector(viewController:finishedWithAuth:error:)];
    [viewController setBrowserCookiesURL:[NSURL URLWithString:@"https://api.singly.com/"]];
    
    // Push the authentication view to our navigation controller instance
    [ [self navigationController] pushViewController:viewController animated:YES];
}

- (IBAction)authorizeWithTwitter
{
    return [self authorize:@"twitter"];
}



@end
