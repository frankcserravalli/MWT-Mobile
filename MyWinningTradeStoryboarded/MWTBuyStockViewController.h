//
//  MWTBuyStockViewController.h
//  MyWinningTradeStoryboarded
//
//  Created by Joseph Levin on 1/24/13.
//  Copyright (c) 2013 Conclave Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MWTBuyStockViewController : UIViewController
- (IBAction)submitButtonAction:(id)sender;
- (IBAction)dismissKeyboard:(id)sender;
- (IBAction)backgroundDismissKeyboard:(id)sender;


@property (strong, nonatomic) IBOutlet UILabel *companyNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *currentPriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *totalPriceToBuyLabel;
@property (strong, nonatomic) IBOutlet UILabel *currentCashLabel;
@property (strong, nonatomic) IBOutlet UILabel *cashAfterPurchaseLabel;
@property (strong, nonatomic) IBOutlet UITextField *volumeTextField;

@end
