//
//  LoginVC.m
//  OWNOWApp
//
//  Created by esharsh on 12/07/16.
//  Copyright © 2016 Esha. All rights reserved.
//

#import "LoginVC.h"

@interface LoginVC () 

@end

@implementation LoginVC
@synthesize imgBg;

#pragma mark - Class Methods

- (void)viewDidLoad {
    [super viewDidLoad];

    [imgBg setImage:[[UIImage imageNamed:@"login_back"] applyBlurWithRadius:18.0 tintColor:[UIColor clearColor] saturationDeltaFactor:1.0 maskImage:nil]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Login with Facebook

- (IBAction)clickForLoginWithFB:(id)sender
{
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions:@[@"public_profile", @"email"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error)
    {
        if (error) {
            
            NSLog(@"Manager Err :: %@", error.localizedDescription);
        }
        else if (result.isCancelled) {
            
            NSLog(@"Request Cancelled");
        }
        
        //Valid
        else {
            
            FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields":@"id, name, first_name, last_name, email"}];
            
            [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error)
            {
                if (!error) {
                     
                    NSLog(@"Dict :: %@", result);
                }
                else {
                    
                    NSLog(@"Graph Err :: %@", error.localizedDescription);
                }
            }];
        }
    }];
}

#pragma mark - Login with Google

- (IBAction)clickForLoginWithGoogle:(id)sender
{
    GIDSignIn *signIn = [GIDSignIn sharedInstance];
    signIn.clientID = @"CLIENT_ID";
    //Google iOS Key :: iOS_KEY
    
    signIn.shouldFetchBasicProfile = true;
    signIn.delegate = self;
    signIn.uiDelegate = self;
    
    [signIn signIn];
}

- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error
{
    if (!error) {
        
        if (user.authentication) {
            
            NSLog(@"Data :: %@", user.profile);
        }
        else {
            
            NSLog(@"User not authorised");
        }
    }
    else {
        
        NSLog(@"Error :: %@", error.localizedDescription);
    }
}

- (void)signIn:(GIDSignIn *)signIn didDisconnectWithUser:(GIDGoogleUser *)user withError:(NSError *)error
{
    NSLog(@"Disconnect Error :: %@", error.localizedDescription);
}

#pragma mark - Logout

- (void)logoutUserData
{
    if ([FBSDKAccessToken currentAccessToken])
        [[[FBSDKLoginManager alloc] init] logOut];
    else
        [[GIDSignIn sharedInstance] signOut];
    
    [self viewWillAppear:true];
}
*/
- (IBAction)btnClose:(id)sender {
}
 
- (IBAction)btnLoginClick:(id)sender {
}
@end
