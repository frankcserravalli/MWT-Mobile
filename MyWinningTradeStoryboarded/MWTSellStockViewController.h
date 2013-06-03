//
//  MWTSellStockViewController.h
//  MyWinningTradeStoryboarded
//
//  Created by Joseph Levin on 1/24/13.
//  Copyright (c) 2013 Conclave Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWTStockDetail.h"
#import "MWTStock.h"
#import "MWTPortfolio.h"
#import "AFNetworking.h"
#import "MWTAPIClient.h"

@interface MWTSellStockViewController : UIViewController
- (void) assignValues;
- (void) connectToAPIPath:(NSString *)pathToAPI toSell:(NSInteger)amountOfShares ofStock:(NSString *)stockSymbol;
- (IBAction)submitButtonAction:(id)sender;
- (IBAction)cancelButtonAction:(id)sender;
- (IBAction)backgroundDismissKeyboard:(id)sender;
- (IBAction)dismissKeyboard:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *companyNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *currentPriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *totalLabel;
@property (strong, nonatomic) IBOutlet UILabel *cashAfterTransactionLabel;
@property (strong, nonatomic) IBOutlet UILabel *volumeHeld;
@property (strong, nonatomic) IBOutlet UITextField *volumeTextField;
@property (strong, nonatomic) IBOutlet UIButton *submitButton;
@property (strong, nonatomic) IBOutlet UIButton *cancelButton;
@property float volume;
@property (strong, nonatomic) NSString *stockSymbol;
@property (strong, nonatomic) NSNumber *cash;

@property (strong, nonatomic) NSNumberFormatter *numberToCurrencyConverter;


@property (strong, nonatomic) MWTStock *stock;
@property (strong, nonatomic) MWTStockDetail *stockDetail;
@property (strong, nonatomic) MWTPortfolio *portfolio;


@end
