//
//  TextDetailViewController.m
//  iosdevcamp2012
//
//  Created by Christopher Brown on 7/22/12.
//  Copyright (c) 2012 Millennial Media. All rights reserved.
//

#import "TextDetailViewController.h"

@implementation TextDetailViewController
@synthesize token;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - Singly methods

- (GTMOAuth2Authentication *)singlyAuth
{
    
    // Set the token URL to the Singly token endpoint.
    NSURL *tokenURL = [NSURL URLWithString:@"https://api.singly.com/oauth/access_token"];
    
    // Set a bogus redirect URI. It won't actually be used as the redirect will
    // be intercepted by the OAuth library and handled in the app.
    NSString *redirectURI = @"http://api.singly.com/OAuthCallback";
    
    GTMOAuth2Authentication *auth;
    auth = [GTMOAuth2Authentication authenticationWithServiceProvider:@"Singly API"
                                                             tokenURL:tokenURL
                                                          redirectURI:redirectURI
                                                             clientID:kMyClientID
                                                         clientSecret:kMyClientSecret];
    
    // The Singly API does not return a token type, therefore we set one here to
    // avoid a warning being thrown.
    [auth setTokenType:@"Bearer"];
    
    return auth;
}



- (void)authorize:(NSString *)service
{
    GTMOAuth2Authentication *auth = [self singlyAuth];
    
    // Prepare the Authorization URL. We will pass in the name of the service
    // that we wish to authorize with.
    NSURL *authURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.singly.com/oauth/authorize?service=%@", service]];
    
    // Display the authentication view
    GTMOAuth2ViewControllerTouch *viewController;
    viewController = [ [GTMOAuth2ViewControllerTouch alloc] initWithAuthentication:auth
                                                                  authorizationURL:authURL
                                                                  keychainItemName:nil
                                                                          delegate:self
                                                                  finishedSelector:@selector(viewController:finishedWithAuth:error:)];
    [viewController setBrowserCookiesURL:[NSURL URLWithString:@"https://api.singly.com/"]];
    
    // Push the authentication view to our navigation controller instance
    //[ [self navigationController] pushViewController:viewController animated:YES];
    
    
    [[self navigationController] presentModalViewController:viewController animated:YES];
}




- (void)viewController:(GTMOAuth2ViewControllerTouch *)viewController
      finishedWithAuth:(GTMOAuth2Authentication *)auth
                 error:(NSError *)error {
    if (error != nil) {
        NSLog(@"viewController:finishedWithAuth:error: FAILED");
        // Authentication failed
    } else {
        NSLog(@"viewController:finishedWithAuth:error: SUCCEEDED, %@", auth);
        self.token = auth.accessToken;
        // Authentication succeeded
    }
}

- (void)authentication:(GTMOAuth2Authentication *)auth
               request:(NSMutableURLRequest *)request
     finishedWithError:(NSError *)error {
    if (error != nil) {
        NSLog(@"authentication:request:finishedWithError: FAILED");
        // Authorization failed
    } else {
        NSLog(@"authentication:request:finishedWithError: SUCCEEDED");
        // Authorization succeeded
    }
}



- (IBAction)authorizeWithTwitter
{
    return [self authorize:@"twitter"];
}








#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
