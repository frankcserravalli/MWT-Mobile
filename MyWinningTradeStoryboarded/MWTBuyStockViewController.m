//
//  MWTBuyStockViewController.m
//  MyWinningTradeStoryboarded
//
//  Created by Joseph Levin on 1/24/13.
//  Copyright (c) 2013 Conclave Labs. All rights reserved.
//

#import "MWTBuyStockViewController.h"

@interface MWTBuyStockViewController ()

@end

@implementation MWTBuyStockViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitButtonAction:(id)sender
{
    NSLog(@"Bought %i shares", [[_volumeTextField text] integerValue]);
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)dismissKeyboard:(id)sender
{
    [sender resignFirstResponder];
}

- (IBAction)backgroundDismissKeyboard:(id)sender
{
    [_volumeTextField resignFirstResponder];
}

@end
