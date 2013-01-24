//
//  MWTStockDetailViewController.h
//  MyWinningTradeStoryboarded
//
//  Created by Joseph Levin on 1/22/13.
//  Copyright (c) 2013 Conclave Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWTPortfolio.h"

@interface MWTStockDetailViewController : UIViewController

@property (strong, nonatomic) MWTPortfolio *portfolio;
@property (strong, nonatomic) NSDictionary *stockDetails;

@property (strong, nonatomic) IBOutlet UILabel *buyPriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *percentChangeLabel;
@property (strong, nonatomic) IBOutlet UILabel *pointChangeLabel;
@property (strong, nonatomic) IBOutlet UILabel *peRatioLabel;
@property (strong, nonatomic) IBOutlet UILabel *volumeLabel;
@property (strong, nonatomic) IBOutlet UILabel *companyNameLabel;

-(void)getStockDetails;
-(void)parseStock:(NSData *)data;
-(void)assignLabels;

@end
