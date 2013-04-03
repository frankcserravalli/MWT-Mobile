//
//  MWTStockDetailViewController.h
//  MyWinningTradeStoryboarded
//
//  Created by Joseph Levin on 1/22/13.
//  Copyright (c) 2013 Conclave Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWTStock.h"

@interface MWTStockDetailViewController : UIViewController

@property (strong, nonatomic) MWTStock *stock;

@property (strong, nonatomic) IBOutlet UILabel *buyPriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *percentChangeLabel;
@property (strong, nonatomic) IBOutlet UILabel *pointChangeLabel;
@property (strong, nonatomic) IBOutlet UILabel *peRatioLabel;
@property (strong, nonatomic) IBOutlet UILabel *volumeLabel;
@property (strong, nonatomic) IBOutlet UILabel *companyNameLabel;
@property (strong, nonatomic) IBOutlet UIWebView *chartView;

-(void)assignLabels;
- (IBAction)buyButtonAction:(id)sender;
- (IBAction)sellButtonAction:(id)sender;
- (IBAction)shortButtonAction:(id)sender;

@end
