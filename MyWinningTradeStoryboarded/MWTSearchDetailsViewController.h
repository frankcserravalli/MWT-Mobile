//
//  MWTSearchDetailsViewController.h
//  MyWinningTradeStoryboarded
//
//  Created by Joseph Levin on 6/5/13.
//  Copyright (c) 2013 Conclave Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWTSearchResult.h"
#import "MWTStockDetail.h"
#import "MWTPortfolio.h"
#import "AFNetworking.h"
#import "MWTAPIClient.h"
#import "SVProgressHUD.h"

@interface MWTSearchDetailsViewController : UIViewController

@property (strong, nonatomic) MWTSearchResult *searchResult;
@property (strong, nonatomic) MWTStockDetail *stockDetail;
@property (strong, nonatomic) MWTPortfolio *portfolio;

@property (strong, nonatomic) IBOutlet UILabel *buyPriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *percentChangeLabel;
@property (strong, nonatomic) IBOutlet UILabel *pointChangeLabel;
@property (strong, nonatomic) IBOutlet UILabel *peRatioLabel;
@property (strong, nonatomic) IBOutlet UILabel *volumeLabel;
@property (strong, nonatomic) IBOutlet UILabel *companyNameLabel;
@property (strong, nonatomic) IBOutlet UIButton *buyButton;
@property (strong, nonatomic) IBOutlet UIButton *shortButton;
@property (strong, nonatomic) IBOutlet UIButton *sellButton;

- (IBAction)buyButtonAction:(id)sender;
- (IBAction)shortButtonAction:(id)sender;
- (IBAction)sellButtonAction:(id)sender;


@end
