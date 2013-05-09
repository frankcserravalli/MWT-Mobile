//
//  MWTBuyNewStockViewController.h
//  MyWinningTradeStoryboarded
//
//  Created by Joseph Levin on 5/9/13.
//  Copyright (c) 2013 Conclave Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWTStock.h"
#import "MWTPortfolio.h"
#import "MWTStockDetail.h"
#import "AFNetworking.h"
#import "MWTAPIClient.h"
#import "SVProgressHUD.h"

@interface MWTBuyNewStockViewController : UIViewController
- (IBAction)dismissKeyboard:(id)sender;
- (IBAction)submitPurchase:(id)sender;
- (IBAction)cancelPurchase:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *companyName;
@property (strong, nonatomic) IBOutlet UILabel *currentPrice;
@property (strong, nonatomic) IBOutlet UILabel *totalPrice;
@property (strong, nonatomic) IBOutlet UILabel *cash;
@property (strong, nonatomic) IBOutlet UILabel *postPurchaseCash;
@property (strong, nonatomic) IBOutlet UITextField *volumeTextField;
@property (strong, nonatomic) IBOutlet UIButton *submit;
@property (strong, nonatomic) IBOutlet UIButton *cancel;

@property float volume;

@property (strong, nonatomic) MWTStock *stock;
@property (strong, nonatomic) MWTStockDetail *stockDeetz;
@property (strong, nonatomic) MWTPortfolio *portfolio;

@end
