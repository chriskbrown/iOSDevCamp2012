//
//  CameraController.m
//  iosdevcamp2012
//
//  Created by Mark Burger on 7/21/12.
//  Copyright (c) 2012 Millennial Media. All rights reserved.
//

#import <MobileCoreServices/UTCoreTypes.h>
#import <MediaPlayer/MPMoviePlayerController.h>
#import "CameraController.h"
#import "baseapi.h"


#import <stdlib.h>

@implementation CameraController


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
    tess->Init([ dataPath cStringUsingEncoding:NSUTF8StringEncoding], "../eng" );
    
    return tess;
}

- (NSString *) stringFromImage:(UIImage *)img {
    // This was jeeped from a certain Mr. Nolan Brown.
    uint32_t *pixels;
    tesseract::TessBaseAPI *tess = [self initTess];
   
    
    //****** CRASH HERE. SIGABRT
    
    /*
     Error opening data file /var/mobile/Applications/48F6D76E-EDA8-4C15-AAFC-3DEEEB3251BC/Documents/../iosdevcamp2012.app/tessdata/../eng.traineddata
     iosdevcamp2012(2625,0x3ed6ad98) malloc: *** error for object 0x32b17717: pointer being freed was not allocated
     *** set a breakpoint in malloc_error_break to debug
     
     */
    
    
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
    CGContextRef context = CGBitmapContextCreate(pixels, width, height, 8, width * sizeof(uint32_t), colorSpace, 
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedLast);
	
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

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // TODO: Buffer text. uffer text. ffer text. <-- So this doesn't happen.
    // TODO: Check for carriage returns and parse accordingly. :-D
    NSLog(@"Delegate answered.");
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ( [type isEqualToString:@"public.image"] ) {
        UIActivityIndicatorView *aiv = [UIActivityIndicatorView new];
        aiv.autoresizingMask = UIViewAutoresizingFlexibleWidth |
        UIViewAutoresizingFlexibleHeight;
        
        [self.view addSubview:aiv];
        
        NSString *sfi = [self stringFromImage:[info objectForKey:UIImagePickerControllerOriginalImage]];
        // TODO: Split up and reassemble image/strings for font purposes and throw it in a thread.
        
        [aiv removeFromSuperview];
        
        NSLog(@"%@", sfi);
        NSLog( @"Image finished.");
    } else if ( [type isEqualToString:@"public.movie"] ) {
        MPMoviePlayerController *mpc = [MPMoviePlayerController new];
        [mpc setContentURL:[info objectForKey:UIImagePickerControllerMediaURL] ];
        
        UIImage *img;
        int i;
        for ( i = 0; i < 2*mpc.duration; i++ ) {
            img = [mpc thumbnailImageAtTime:(i/2) timeOption:MPMovieTimeOptionNearestKeyFrame];
            NSString *sfi = [self stringFromImage:img];
            
            NSLog( @"%@", sfi);
            NSLog( @"Video finished.");
        }
        
        NSLog(@"VIIIIIDYO!");
    }

    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissModalViewControllerAnimated:YES];
}


@end
