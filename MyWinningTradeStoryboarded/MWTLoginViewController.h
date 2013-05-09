//
//  MWTLoginViewController.h
//  MyWinningTradeStoryboarded
//
//  Created by Joseph Levin on 1/17/13.
//  Copyright (c) 2013 Conclave Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWTAPIClient.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"

@interface MWTLoginViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *emailTextfield;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextfield;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;

- (IBAction)backgroundDismissKeyboard:(id)sender;
- (IBAction)login:(id)sender;

@property (strong, nonatomic) NSMutableData *responseData;

@property float animatedDistance;


@end
