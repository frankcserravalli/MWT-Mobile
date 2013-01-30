//
//  MWTSellStockViewController.h
//  MyWinningTradeStoryboarded
//
//  Created by Joseph Levin on 1/24/13.
//  Copyright (c) 2013 Conclave Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWTPortfolioSingleton.h"

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
@property (strong, nonatomic) IBOutlet UITextField *volumeTextField;
@property float volume;
@property (strong, nonatomic) NSString *stockSymbol;
@property (strong, nonatomic) NSNumber *cash;

@end
