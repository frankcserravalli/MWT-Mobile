//
//  MWTPortfolioCell.h
//  MyWinningTradeStoryboarded
//
//  Created by Joseph Levin on 1/21/13.
//  Copyright (c) 2013 Conclave Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MWTPortfolioStockCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *percentGainLabel;
@property (strong, nonatomic) IBOutlet UILabel *symbolLabel;
@property (strong, nonatomic) IBOutlet UILabel *sharesLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UILabel *sharesLabelText;

@end
