//
//  CameraController.m
//  iosdevcamp2012
//
//  Created by Mark Burger on 7/21/12
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

#import <MobileCoreServices/UTCoreTypes.h>
#import <MediaPlayer/MPMoviePlayerController.h>
#import "CameraController.h"
#import "baseapi.h"


#import <stdlib.h>

@implementation CameraController
@synthesize managedObjectContext = _managedObjectContext;

- (id) init {
    self = [super init];
    if ( self != nil ) { 
        self.delegate = self;
    
    }
    return self;
}

- (tesseract::TessBaseAPI *) initTess {
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);                                                     
    NSString *documentPath = ([documentPaths count] > 0) ? [documentPaths objectAtIndex:0] : nil;                                                                 
    
    NSString *dataPath = [documentPath stringByAppendingPathComponent:@"../iosdevcamp2012.app"];                                                                               
    NSFileManager *fileManager = [NSFileManager defaultManager];                                                                                                  
    // If the expected store doesn't exist, copy the default store.
    if (![fileManager fileExistsAtPath:dataPath]) {
        // get the path to the app bundle (with the tessdata dir)
        NSString *bundlePath = [[NSBundle mainBundle] bundlePath];                                                                                                
        NSString *tessdataPath = [bundlePath stringByAppendingPathComponent:@"../iosdevcamp2012.app"];                                                                         
        if (tessdataPath) {
            [fileManager copyItemAtPath:tessdataPath toPath:dataPath error:NULL];                                                                                 
        }
    }
    
    setenv("TESSDATA_PREFIX", [[dataPath stringByAppendingString:@"/"] UTF8String], 1);
    
    tesseract::TessBaseAPI* tess = new tesseract::TessBaseAPI();
    tess->Init([ dataPath cStringUsingEncoding:NSUTF8StringEncoding], "eng" );
    
    return tess;
}

- (NSString *) stringFromImage:(UIImage *)img {
    // This was jeeped from a certain Mr. Nolan Brown. I hear he's a tool.
    // https://github.com/nolanbrown/Tesseract-iPhone-Demo
    
    uint32_t *pixels;
    tesseract::TessBaseAPI *tess = [self initTess];
    
    CGSize size = [img size];
    int width = size.width;
    int height = size.height;
	
	if (width <= 0 || height <= 0)
		return nil;
	
    // the pixels will be painted to this array
    pixels = (uint32_t *) malloc(width * height * sizeof(uint32_t));
    // clear the pixels so any transparency is preserved
    memset(pixels, 0, width * height * sizeof(uint32_t));
	
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	
    // create a context with RGBA pixels
    CGContextRef context = CGBitmapContextCreate(pixels, width, height, 8, width * sizeof(uint32_t), colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedLast);
	
    // paint the bitmap to our context which will fill in the pixels array
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), [img CGImage]);
	
	// we're done with the context and color space
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    tess->SetImage((const unsigned char *) pixels, width, height, sizeof(uint32_t), width * sizeof(uint32_t));
    tess->Recognize(NULL);
    char* utf8Text = tess->GetUTF8Text();
    free(pixels);
    return [NSString stringWithCString:utf8Text encoding:NSUTF8StringEncoding];
    
   }

- (void) mergeStringArrays:(NSMutableArray *)main: (NSMutableArray *)appendage {
    
}

- (void)processGraphicalData:(NSDictionary *)info {
    NSString *sfi;
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ( [type isEqualToString:@"public.image"] ) {
        sfi = [self stringFromImage:[info objectForKey:UIImagePickerControllerOriginalImage]];
        NSLog(@"%@", sfi);
        [self saveText:sfi];
        
        NSLog( @"Image finished.");
    } else if ( [type isEqualToString:@"public.movie"] ) {
        MPMoviePlayerController *mpc = [MPMoviePlayerController new];
        [mpc setContentURL:[info objectForKey:UIImagePickerControllerMediaURL] ];
        
        UIImage *img;
        int i, j, k;
        j = 0;
        k = 0;
        
        
        for ( i = 0; i < 2*mpc.duration; i++ ) {
            img = [mpc thumbnailImageAtTime:(i/2) timeOption:MPMovieTimeOptionNearestKeyFrame];
            //sfi = [self stringFromImage:img];
            sfi = [NSString stringWithFormat:@"%@%@",sfi,[self stringFromImage:img] ];
            
            /*NSMutableArray *ma = [NSMutableArray new];
             for ( j = 0; j < sfi.length; j++ ) {
             if ( [sfi characterAtIndex:j ] == '\n' ) {
             [ma addObject:[sfi substringWithRange:NSMakeRange(i, k) ]];
             k = j + 1;
             }
             }
             
             for ( j = 0; j < ma.count; j++ ) {
             NSString *main = (NSString *)[mainma objectAtIndex:j];
             
             }
             */
            
            [self saveText:sfi];
            NSLog( @"Video finished.");
        }
        
        [self saveText:sfi];
    }
    [self dismissModalViewControllerAnimated:YES];
}

- (void) showLoad {
    UIView *loadBg = [UIView new];
    UILabel *loadText = [UILabel new];
    
    
    
    [loadBg setBounds:self.view.bounds ];
    [loadBg setCenter:self.view.center ];
    [loadBg setBackgroundColor:[UIColor blackColor] ];
    [self.view addSubview:loadBg];
    
    
    CGPoint p = loadBg.center;
    p.y += 35;
    
    
    UIActivityIndicatorView *indicator = [UIActivityIndicatorView new];
    [indicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge ];
    
    // Set the resizing mask so it's not stretched
    indicator.autoresizingMask =
    UIViewAutoresizingFlexibleTopMargin |
    UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleBottomMargin |
    UIViewAutoresizingFlexibleLeftMargin;
    // Place it in the middle of the view
    indicator.center = self.view.center;
    // Add it into the spinnerView

    
    
    [loadText setText:@"Capturing"];
    [loadText setBackgroundColor:[UIColor clearColor] ];
    [loadText setTextColor:[UIColor whiteColor] ];
    [loadText setBounds:self.view.bounds];
    [loadText setTextAlignment:UITextAlignmentCenter];
    loadText.center = p;
    
    [loadBg addSubview:loadText];
    [loadBg addSubview:indicator];
    // Start it spinning! Don't miss this step
    [indicator startAnimating];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // TODO: Buffer text. uffer text. ffer text. <-- So this doesn't happen.
    // TODO: Check for carriage returns and parse accordingly. :-D

    [self showLoad];
    
    [NSThread detachNewThreadSelector:@selector(processGraphicalData:) toTarget:self withObject:info];


      

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)saveText:(NSString *)text
{
    

    
    if(self.managedObjectContext == nil) 
    {
        NSLog(@"Empty context");
        AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        self.managedObjectContext = delegate.managedObjectContext;

        //self.managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate]managedObjectContext]; 
        
//        self.managedObjectContext = [(AppDelegate *)[[[UIApplication sharedApplication] delegate] managedObjectContext]];
        
        NSLog(@"After managedObjectContext: %@",  self.managedObjectContext);
     
    }
    
    NSLog(@"Context: %@",self.managedObjectContext);
    NSLog(@"PS Coord : %@",self.managedObjectContext.persistentStoreCoordinator);
    NSLog(@"MOM : %@", self.managedObjectContext.persistentStoreCoordinator.managedObjectModel);

    
    NSManagedObject *sessionInfo = [NSEntityDescription
                                    insertNewObjectForEntityForName:@"Session"
                                    inManagedObjectContext:self.managedObjectContext];
    

    NSString *locDescription = [[NSString alloc] initWithString:@"This is a description of a location"];
    [sessionInfo setValue:locDescription forKey:@"location"];
    
    [sessionInfo setValue:[NSDate date] forKey:@"begintime"];
    
    [sessionInfo setValue:text forKey:@"text"];
    
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }

}


@end
