//
//  TextTableViewController.h
//  iosdevcamp2012
//
//  Created by Christopher Brown on 7/21/12.
//  Copyright (c) 2012 Millennial Media. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Session.h"
#import "TextEntry.h"

@interface TextTableViewController : UITableViewController <UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>
{
    // other class ivars
    
    // required ivars for this example
//    NSFetchedResultsController *fetchedResultsController_;
//    NSFetchedResultsController *searchFetchedResultsController_;
//    NSManagedObjectContext *managedObjectContext_;
    
    // The saved state of the search UI if a memory warning removed the view.
//    NSString        *savedSearchTerm_;
//    NSInteger       savedScopeButtonIndex_;
//    BOOL            searchWasActive_;
}

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain, readonly) NSFetchedResultsController *searchFetchedResultsController;

//@property (nonatomic, copy) NSString *savedSearchTerm;
//@property (nonatomic) NSInteger savedScopeButtonIndex;
@property (nonatomic) BOOL searchWasActive;

@end
