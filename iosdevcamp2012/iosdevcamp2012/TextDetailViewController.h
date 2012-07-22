//
//  TextDetailViewController.h
//  iosdevcamp2012
//
//  Created by Christopher Brown on 7/22/12.
//  Copyright (c) 2012 Millennial Media. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTMHTTPFetcher.h"
#import "GTMOAuth2ViewControllerTouch.h"

#define kMyClientID @"3a994803e36ab46763714a79719ca26b"
#define kMyClientSecret @"3a994803e36ab46763714a79719ca26b"

@interface TextDetailViewController : UIViewController

@property (nonatomic, strong) NSString *token;

- (GTMOAuth2Authentication *)singlyAuth;
- (void)authorize:(NSString *)service;
- (IBAction)authorizeWithTwitter;


@end
