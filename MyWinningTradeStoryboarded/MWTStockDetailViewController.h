//
//  MWTStockDetailViewController.h
//  MyWinningTradeStoryboarded
//
//  Created by Joseph Levin on 1/22/13.
//  Copyright (c) 2013 Conclave Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MWTStockDetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *companyNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *capitalGainLabel;
@property (strong, nonatomic) IBOutlet UILabel *percentGainLabel;
@property (strong, nonatomic) IBOutlet UILabel *currentPriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *sharesOwnedLabel;
@property (strong, nonatomic) IBOutlet UILabel *currentValueLabel;
@property (strong, nonatomic) IBOutlet UILabel *costBasisLabel;

@end
