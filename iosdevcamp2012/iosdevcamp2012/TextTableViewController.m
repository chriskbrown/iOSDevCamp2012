//
//  TextTableViewController.m
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


#import "TextTableViewController.h"


@interface TextTableViewController ()
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSFetchedResultsController *searchFetchedResultsController;
@property (nonatomic, retain) UISearchDisplayController *mySearchDisplayController;
@end

@implementation TextTableViewController
@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize mySearchDisplayController;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize searchFetchedResultsController;
@synthesize searchWasActive;
@synthesize sessionData;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
        // Custom initialization
    }
    NSLog(@"Table view controller");
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.title = @"Captured Text";
    
    NSLog(@"view did load");
    
    NSError *error;
	if (![[self fetchedResultsController] performFetch:&error]) {
		// Update to handle the error appropriately.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		exit(-1);  // Fail
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source


-(NSFetchedResultsController *)fetchedResultsController {
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    if(self.managedObjectContext == nil) 
    {
        NSLog(@"Empty context");
        return 0;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Session" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"begintime" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
        
    [fetchRequest setFetchBatchSize:20];
    
    NSFetchedResultsController *frc =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:self.managedObjectContext 
                                        sectionNameKeyPath:nil
                                        cacheName:nil];
    self.fetchedResultsController = frc;
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;    
}


- (NSFetchedResultsController *)fetchedResultsControllerForTableView:(UITableView *)tableView
{
    int i = self.tableView ? 1 : 0;
    NSLog(@"Table view true: %i", i);
    return tableView == self.tableView ? self.fetchedResultsController : self.searchFetchedResultsController;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Session *session = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = session.text;
    
    //Format the timestamp for display
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //[formatter setDateFormat:@"yyyy"];
    [formatter setDateFormat:@"yyyy-MM-dd 'at' HH:mm:ss"];
    
    //Optionally for time zone converstions
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"PDT"]];
    
    NSString *stringFromDate = [formatter stringFromDate:session.begintime];
    
    
    cell.detailTextLabel.text = stringFromDate;
    NSLog(@"Cell text: %@  %@", session.text, stringFromDate);
}



- (void)fetchedResultsController:(NSFetchedResultsController *)fetchedResultsController configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"FRC val:%@", indexPath);
    Session *session = [fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = session.location;
    NSLog(@"Cell text:%@", session.location);

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id  sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    NSLog(@"Number of rows: %i", [sectionInfo numberOfObjects]);
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    NSLog(@"Cell for row:%@", indexPath);
    
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}



#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    NSLog(@"Segue!!!!!!!");

    
    NSLog(@"controllerProgram:: prepareForSegue: %@", segue.identifier );
    
    if ([[segue identifier] isEqualToString:@"showDetailTextView"]) {
        if ([segue.destinationViewController respondsToSelector:@selector(setLabelText:)]) {
            [segue.destinationViewController performSelector:@selector(setLabelText:) 
                                                  withObject:sessionData];
        }     
    
    }
}



@end
