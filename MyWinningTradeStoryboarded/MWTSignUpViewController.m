//
//  MWTSignUpViewController.m
//  MyWinningTradeStoryboarded
//
//  Created by Joseph Levin on 1/17/13.
//  Copyright (c) 2013 Conclave Labs. All rights reserved.
//

#import "MWTSignUpViewController.h"

@interface MWTSignUpViewController ()

- (NSString *)compileFullNameFromFirstName:(NSString *)firstName andLastName:(NSString *)lastName;
- (void) completeRegistrationWith:(id)JSON;

@end

@implementation MWTSignUpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions
- (IBAction)register:(id)sender
{
    [SVProgressHUD showWithStatus:@"Registering"];
    
    /*
     PARAMS
     name, email, password, password_confirmation
     */
    
    NSString *postPath = @"api/v1/users/create";
    
    NSString *name = [self compileFullNameFromFirstName:_firstName.text andLastName:_lastName.text];
    NSString *email = _email.text;
    NSString *password = _password.text;
    NSString *password_confirmation = _confirmPassword.text;
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            name, @"name",
                            email, @"email",
                            password, @"password",
                            password_confirmation, @"password_confirmation",
                            nil];
    
    MWTAPIClient *client = [MWTAPIClient sharedInstance];
    
    NSMutableURLRequest *request = [client requestWithMethod:@"POST" path:postPath parameters:params];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation
                                         JSONRequestOperationWithRequest:request
                                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                             [SVProgressHUD showSuccessWithStatus:@"Registered!"];
                                             [self completeRegistrationWith:JSON];
                                             [self performSegueWithIdentifier:@"RegisterToPortfolio" sender:nil];
                                         }
                                         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                             [SVProgressHUD showErrorWithStatus:@"Server error"];
                                             
                                             NSLog(@"%@", error);
                                         }];
    [operation start];
}

- (IBAction)cancel:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)backgroundTouched:(id)sender
{
    [_lastName resignFirstResponder];
    [_firstName resignFirstResponder];
    [_email resignFirstResponder];
    [_password resignFirstResponder];
    [_confirmPassword resignFirstResponder];
}

#pragma mark - String Manipulation
- (NSString *) compileFullNameFromFirstName:(NSString *)firstName andLastName:(NSString *)lastName
{
    NSString *fullName = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
    
    return fullName;
}

#pragma mark - UITextField Delegate
- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Registration
- (void) completeRegistrationWith:(id)JSON
{
    NSString *user_id = [NSString stringWithFormat:@"%@", [JSON objectForKey:@"user_id"]];
    NSString *ios_token = [NSString stringWithFormat:@"%@", [JSON objectForKey:@"ios_token"]];
    [self saveInUserDefaults:user_id withKey:@"user_id"];
    [self saveInUserDefaults:ios_token withKey:@"ios_token"];    
}

#pragma mark - User Defaults
- (void) saveInUserDefaults:(NSString *)string withKey:(NSString *)stringKey
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:string forKey:stringKey];
    [defaults synchronize];
    
    NSLog([NSString stringWithFormat:@"Saved %@", string]);
}

#pragma mark - Segue
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"RegisterToPortfolio"])
    {
        NSLog(@"performing segue");
    }
}

@end
