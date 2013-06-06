//
//  MWTLoginViewController.m
//  MyWinningTradeStoryboarded
//
//  Created by Joseph Levin on 1/17/13.
//  Copyright (c) 2013 Conclave Labs. All rights reserved.
//

#import "MWTLoginViewController.h"

@interface MWTLoginViewController ()

@end

@implementation MWTLoginViewController

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //self.title = @"Login";
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.png"]];
    self.view.backgroundColor = background;
    
    CGFloat red = 61/255.0f;
    CGFloat green = 80/255.0f;
    CGFloat blue = 100/255.0f;
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:red green:green blue:blue alpha:1];
    
    UIImage *resizableButton = [[UIImage imageNamed:@"button.png" ] resizableImageWithCapInsets:UIEdgeInsetsMake(12, 6, 12, 6)];
    [_loginButton setBackgroundImage:resizableButton forState:UIControlStateNormal];
    [_registerButton setBackgroundImage:resizableButton forState:UIControlStateNormal];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    [self enableKeyboardAppearanceNotifications];
}

- (void) enableKeyboardAppearanceNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
}

#pragma mark - UI Manipulation
- (void) keyboardDidShow:(NSNotification *)notification
{
    NSLog(@"keyboard shown");
    [self pushUpFrameWithTextfield:_emailTextfield];
}

- (void) keyboardDidHide:(NSNotification *)notification
{
    NSLog(@"keyboard hidden");
    [self pushDownFrame];
}


- (void) pushUpFrameWithTextfield:(UITextField *)textField
{
    CGRect textFieldRect = [self.view.window convertRect:textField.bounds fromView:textField];
    CGRect viewRect = [self.view.window convertRect:self.view.bounds fromView:self.view];
    
    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator = midline - viewRect.origin.y - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator = (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION) * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    
    if (heightFraction < 0.0)
    {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0)
    {
        heightFraction = 1.0;
    }
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        _animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
        
    }
    else
    {
        _animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
    
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= _animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
    
}

- (void) pushDownFrame
{
    
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += _animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
    
}



- (void) viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (IBAction)backgroundDismissKeyboard:(id)sender
{
    [_emailTextfield resignFirstResponder];
    [_passwordTextfield resignFirstResponder];
}

- (IBAction)login:(id)sender
{
//    NSString *loginURLString = [NSString stringWithFormat:@"http://%@/api/v1/", serverURL];
//    NSURL *loginURL = [NSURL URLWithString:loginURLString];
//    
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:loginURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
//    [request setHTTPMethod:@"GET"];
//    
//    NSError *requestError;
//    
//    NSURLResponse *urlResponse = nil;
//    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
//    
//    SBJsonParser *parser = [[SBJsonParser alloc] init];
//    NSDictionary *loginResponse = [parser objectWithData:response];
//    
//    if ([[loginResponse objectForKey:@""] isEqualToString:@"login successful"])
//    {
//        [self performSegueWithIdentifier:@"Login" sender:self];
//    }
    
    
//    [self setUpConnectionFor:_emailTextfield.text andPassword:_passwordTextfield.text];
    [[AFNetworkActivityIndicatorManager sharedManager] incrementActivityCount];
    [SVProgressHUD showWithStatus:@"Logging in"];
    
    NSString *email = _emailTextfield.text;
    NSString *password = _passwordTextfield.text;
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            email, @"email",
                            password, @"password",
                            nil];
    
    NSString *postPath = @"/api/v1/users/authenticate";
    
    MWTAPIClient *client = [MWTAPIClient sharedInstance];

    NSURLRequest *request = [client requestWithMethod:@"POST" path:postPath parameters:params];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation
                                         JSONRequestOperationWithRequest:request
                                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                             NSLog(@"%@", JSON);
                                             NSDictionary *JSONDict = (NSDictionary *)JSON;
                                             if ([[JSONDict objectForKey:@"status"] isEqualToString:@"Password incorrect."] ||
                                                 [[JSONDict objectForKey:@"status"] isEqualToString:@"Account doesn't exist."])
                                             {
                                                 [SVProgressHUD showErrorWithStatus:@"Invalid credentials!"];
                                             }
                                             else
                                             {
                                                 [self completeLoginWith:JSON];
                                                 [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];
                                                 [SVProgressHUD showSuccessWithStatus:@"Logged in!"];
                                             }
                                         }
                                         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                             NSLog(@"%@", error);
                                             [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];
                                             [SVProgressHUD showErrorWithStatus:@"Server error"];
                                         }];
    [operation start];

}

- (void) completeLoginWith:(id)JSON
{
    NSString *user_id = [NSString stringWithFormat:@"%@", [JSON objectForKey:@"user_id"]];
    NSString *ios_token = [NSString stringWithFormat:@"%@", [JSON objectForKey:@"ios_token"]];
    [self saveInUserDefaults:user_id withKey:@"user_id"];
    [self saveInUserDefaults:ios_token withKey:@"ios_token"];
    
    [self performSegueWithIdentifier:@"Login" sender:self];
}

//#pragma mark - Set Up Connection
//
//- (void) setUpConnectionFor:(NSString *)email andPassword:(NSString *)password
//{
//    NSURL *theURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/api/v1/users/authenticate", serverURL]];
//    NSString *bodyString = [NSString stringWithFormat:@"email=%@&password=%@", email, password];
//    
//    double timeOutInterval = 60.0;
//    
//    NSMutableData *POSTData = [NSMutableData data];
//    [POSTData appendData:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
//    NSString *POSTLength = [NSString stringWithFormat:@"%d", [POSTData length]];
//    
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:timeOutInterval];
//    [request setHTTPMethod:@"POST"];
//    [request setValue:POSTLength forHTTPHeaderField:@"Content-Length"];
//    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//    [request setHTTPBody:POSTData];
//    
//    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
//}
//
//#pragma mark - NSURLConnection Delegate Methods
//- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
//{
//    _responseData = [[NSMutableData alloc] init];
//    [_responseData setLength:0];
//}
//
//- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
//{
//    [_responseData appendData:data];
//}
//
//- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
//{
//    _responseData = nil;
//    NSLog(@"Connection failed, error - %@ %@",
//          [error localizedDescription],
//          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
//
//}
//
//- (void)connectionDidFinishLoading:(NSURLConnection *)connection
//{
//    NSLog(@"Connection successful! Received %d bytes of data", _responseData.length);
//    NSString *responseString = [[NSString alloc] initWithData:_responseData encoding:NSASCIIStringEncoding];
//    NSLog(responseString);
//    
//    if (responseString.length > 30)
//    {
//        NSDictionary *userInfoDictionary = [self receiveJSON];
//        NSString *user_id = [NSString stringWithFormat:@"%i", [[userInfoDictionary objectForKey:@"user_id"] intValue]];        
//        NSString *ios_token = [NSString stringWithFormat:[userInfoDictionary objectForKey:@"ios_token"]];
//
//        [self saveInUserDefaults:user_id withKey:@"user_id"];
//        [self saveInUserDefaults:ios_token withKey:@"ios_token"];
//
////        MWTPortfolioSingleton *portfolioSingleton = [MWTPortfolioSingleton sharedInstance];
////        sleep(3);
////        [self performSegueWithIdentifier:@"Login" sender:self];
//        [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(fireTimer:) userInfo:nil repeats:NO];
//    }
//    else
//    {
//        NSLog(@"Login unsuccessful");
//    }
//
//}
//
//- (void) fireTimer:(NSTimer *)timer
//{
//    [self performSegueWithIdentifier:@"Login" sender:self];
//}
//
#pragma mark - User Defaults
- (void) saveInUserDefaults:(NSString *)string withKey:(NSString *)stringKey
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:string forKey:stringKey];
    [defaults synchronize];
    
    NSLog([NSString stringWithFormat:@"Saved %@", string]);
}

//#pragma mark - JSON
//- (NSDictionary *)receiveJSON
//{
//    NSError *JSONError = nil;
//    id JSONObject = [NSJSONSerialization JSONObjectWithData:_responseData options:kNilOptions error:&JSONError];
//    
//    if ([JSONObject isKindOfClass:[NSArray class]])
//    {
//        NSArray *JSONArray = (NSArray *)JSONObject;
//        return [NSDictionary dictionaryWithObject:JSONArray forKey:@"JSONArray"];
//    }
//    else
//    {
//        NSDictionary *JSONDictionary = (NSDictionary *)JSONObject;
//        return JSONDictionary;
//    }
//}

@end
