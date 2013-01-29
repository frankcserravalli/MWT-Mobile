//
//  MWTPortfolioSingleton.h
//  MyWinningTradeStoryboarded
//
//  Created by Joseph Levin on 1/29/13.
//  Copyright (c) 2013 Conclave Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MWTPortfolio.h"


@interface MWTPortfolioSingleton : NSObject
{
}

@property (nonatomic, retain) MWTPortfolio *userPortfolio;

+ (id) sharedInstance;

@end
