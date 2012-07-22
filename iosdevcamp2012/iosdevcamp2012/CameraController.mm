//
//  CameraController.m
//  iosdevcamp2012
//
//  Created by Mark Burger on 7/21/12.
//  Copyright (c) 2012 Millennial Media. All rights reserved.
//


#import "CameraController.h"
#import "baseapi.h"

@implementation CameraController

@synthesize ipc;

- (void) launchCamera:(UIViewController *)controller {
    if ([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeCamera] == NO) {
        NSLog( @"No camera!" );
        return;
    }
    
    ipc = [UIImagePickerController new];
    [ipc setSourceType:UIImagePickerControllerCameraCaptureModeVideo];
    [ipc setDelegate:self];
    [controller presentModalViewController:controller animated:YES];
}

- (NSString *) stringFromImage:(UIImage *)img {
    // This was jeeped from a certain Mr. Nolan Brown.
    TessBaseAPI *tess = new TessBaseAPI();
    tess->SimpleInit([ [self applicationDocumentsDirectory] cStringUsingEncoding:NSUTF8StringEncoding], "eng", false );
    
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
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
//    if ( [type isEqualToString:<#(NSString *)#>
    
    [ipc dismissModalViewControllerAnimated:YES];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [ipc dismissModalViewControllerAnimated:YES];
}


@end
