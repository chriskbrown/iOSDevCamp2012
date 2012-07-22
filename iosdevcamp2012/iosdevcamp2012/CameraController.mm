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

@implementation CameraController

@synthesize dataPath;

- (id) init {
    self = [super init];
    if ( self != nil ) { 
        self.delegate = self;
    }
    return self;
}

- (NSString *) stringFromImage:(UIImage *)img {
    // This was jeeped from a certain Mr. Nolan Brown.
    TessBaseAPI *tess = new TessBaseAPI();
    tess->SimpleInit([ dataPath cStringUsingEncoding:NSUTF8StringEncoding], "eng", false );
    
    CGSize imageSize = [img size];
    double bytes_per_line	= CGImageGetBytesPerRow([img CGImage]);
    double bytes_per_pixel	= CGImageGetBitsPerPixel([img CGImage]) / 8.0;
    
    CFDataRef data = CGDataProviderCopyData(CGImageGetDataProvider([img CGImage]));
    const UInt8 *imageData = CFDataGetBytePtr(data);
    
    // this could take a while. maybe needs to happen asynchronously.
    char* text = tess->TesseractRect(imageData,(int)bytes_per_pixel,(int)bytes_per_line, 0, 0,(int) imageSize.height,(int) imageSize.width);
    
    // Do something useful with the text!
    NSLog(@"Converted text: %@",[NSString stringWithCString:text encoding:NSUTF8StringEncoding]);
    
    return [NSString stringWithCString:text encoding:NSUTF8StringEncoding];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // TODO: Buffer text. uffer text. ffer text. <-- So this doesn't happen.
    // TODO: Check for carriage returns and parse accordingly. :-D
    NSLog(@"Delegate answered.");
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ( [type isEqualToString:@"public.image"] ) {
        NSString *sfi = [self stringFromImage:[info objectForKey:UIImagePickerControllerOriginalImage]];
        // TODO: Split up and reassemble image/strings for font purposes and throw it in a thread.
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
    
}


@end
