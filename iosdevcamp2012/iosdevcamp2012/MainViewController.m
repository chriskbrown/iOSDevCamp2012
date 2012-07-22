//
//  MainViewController.m
//  iosdevcamp2012
//
//  Created by Christopher Brown on 7/21/12.
//

#import "MainViewController.h"

@implementation MainViewController

@synthesize managedObjectContext = _managedObjectContext;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    
    
    NSManagedObject *sessionInfo = [NSEntityDescription
                                    insertNewObjectForEntityForName:@"Session"
                                    inManagedObjectContext:self.managedObjectContext];
    //[sessionInfo setValue:NSNumber forKey:@"latitude"];

    NSManagedObject *textEntryInfo = [NSEntityDescription
                                          insertNewObjectForEntityForName:@"TextEntry"
                                          inManagedObjectContext:self.managedObjectContext];
    
    
    //if ([locObj valueForKey:@"longitude"] != NULL) {
       // NSNumber *longitude = [NSNumber numberWithDouble:lon];
   // NSNumber *longitude = [NSNumber numberWithString:@"-117.0987"];
    NSString *locDescription = [[NSString alloc] initWithString:@"This is a description of a location"];
    [sessionInfo setValue:locDescription forKey:@"location"];
    
    NSString *body = [[NSString alloc] initWithString:@"This is some sample text"];
    [textEntryInfo setValue:body forKey:@"body"];
    
    //NSDate *date = ;
    //NSTimeInterval nowTimeIntervalSince1970 = [[NSDate date] timeIntervalSince1970];
    
    [sessionInfo setValue:[NSDate date] forKey:@"begintime"];
    
   // }
    
//    [failedBankDetails setValue:[NSDate date] forKey:@"closeDate"];
//    [failedBankDetails setValue:[NSDate date] forKey:@"updateDate"];
//    [failedBankDetails setValue:[NSNumber numberWithInt:12345] forKey:@"zip"];
//    [failedBankDetails setValue:sessionInfo forKey:@"info"];
//    [failedBankInfo setValue:failedBankDetails forKey:@"details"];
    
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
        
        NSManagedObject *textEntryObject = [sessionObject valueForKey:@"textentry"];
        NSLog(@"Text body: %@", [textEntryObject valueForKey:@"body"]);
    }
    
    
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
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
    }
}

@end
