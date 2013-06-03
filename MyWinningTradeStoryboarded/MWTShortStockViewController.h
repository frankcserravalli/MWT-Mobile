//
//  MWTShortStockViewController.h
//  MyWinningTradeStoryboarded
//
//  Created by Joseph Levin on 1/24/13.
//  Copyright (c) 2013 Conclave Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWTStock.h"
#import "MWTStockDetail.h"
#import "MWTPortfolio.h"
#import "MWTAPIClient.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"

@interface MWTShortStockViewController : UIViewController <UITextFieldDelegate>
- (IBAction)submitButtonAction:(id)sender;
- (IBAction)backgroundPressed:(id)sender;
- (IBAction)cancel:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *companyName;
@property (strong, nonatomic) IBOutlet UILabel *currentPrice;
@property (strong, nonatomic) IBOutlet UITextField *volumeField;
@property (strong, nonatomic) IBOutlet UILabel *borrowTotal;
@property (strong, nonatomic) IBOutlet UIButton *submitButton;
@property (strong, nonatomic) IBOutlet UIButton *cancelButton;

@property (strong, nonatomic) MWTStock *stock;
@property (strong, nonatomic) MWTStockDetail *stockDetail;
@property (strong, nonatomic) MWTPortfolio *portfolio;
@property float volume;

@property (strong, nonatomic) NSNumberFormatter *numberToCurrencyConverter;


@end
