//
//  MWTLoginViewController.h
//  MyWinningTradeStoryboarded
//
//  Created by Joseph Levin on 1/17/13.
//  Copyright (c) 2013 Conclave Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MWTLoginViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *emailTextfield;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextfield;

- (IBAction)backgroundDismissKeyboard:(id)sender;
- (IBAction)login:(id)sender;

@end
