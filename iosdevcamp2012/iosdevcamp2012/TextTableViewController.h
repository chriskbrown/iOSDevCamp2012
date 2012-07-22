//
//  TextTableViewController.h
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
//

#import <UIKit/UIKit.h>
#import "Session.h"
#import "TextEntry.h"
#import "TextDetailViewController.h"

@interface TextTableViewController : UITableViewController <UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain, readonly) NSFetchedResultsController *searchFetchedResultsController;
@property (nonatomic, retain, readonly) Session *sessionData;

@property (nonatomic) BOOL searchWasActive;

@end
