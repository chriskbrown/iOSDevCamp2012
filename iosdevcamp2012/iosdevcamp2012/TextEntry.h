//
//  TextEntry.h
//  iosdevcamp2012
//
//  Created by Christopher Brown on 7/21/12.
//  Copyright (c) 2012 Millennial Media. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Session;

@interface TextEntry : NSManagedObject

@property (nonatomic, retain) NSString * body;
@property (nonatomic, retain) Session *Session;

@end
