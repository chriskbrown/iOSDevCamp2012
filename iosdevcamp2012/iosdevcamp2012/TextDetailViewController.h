//
//  TextDetailViewController.h
//  iosdevcamp2012
//
//  Created by Christopher Brown on 7/22/12.
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

#import <UIKit/UIKit.h>
#import "GTMHTTPFetcher.h"
#import "GTMOAuth2ViewControllerTouch.h"
#import "Session.h"

#define kMyClientID @"3a994803e36ab46763714a79719ca26b"
#define kMyClientSecret @"3a994803e36ab46763714a79719ca26b"

@interface TextDetailViewController : UIViewController

@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) IBOutlet UILabel *label;

- (GTMOAuth2Authentication *)singlyAuth;
- (void)authorize:(NSString *)service;
- (IBAction)authorizeWithTwitter;
- (void) setLabelText:(Session *)sessionObject;

@end
