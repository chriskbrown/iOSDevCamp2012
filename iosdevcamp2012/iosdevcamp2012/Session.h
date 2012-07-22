//
//  Session.h
//  iosdevcamp2012
//
//  Created by Christopher Brown on 7/21/12.
//  Copyright (c) 2012 Millennial Media. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Session : NSManagedObject

@property (nonatomic, retain) NSDate * begintime;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSOrderedSet *textentry;
@end

@interface Session (CoreDataGeneratedAccessors)

- (void)insertObject:(NSManagedObject *)value inTextentryAtIndex:(NSUInteger)idx;
- (void)removeObjectFromTextentryAtIndex:(NSUInteger)idx;
- (void)insertTextentry:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeTextentryAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInTextentryAtIndex:(NSUInteger)idx withObject:(NSManagedObject *)value;
- (void)replaceTextentryAtIndexes:(NSIndexSet *)indexes withTextentry:(NSArray *)values;
- (void)addTextentryObject:(NSManagedObject *)value;
- (void)removeTextentryObject:(NSManagedObject *)value;
- (void)addTextentry:(NSOrderedSet *)values;
- (void)removeTextentry:(NSOrderedSet *)values;
@end
