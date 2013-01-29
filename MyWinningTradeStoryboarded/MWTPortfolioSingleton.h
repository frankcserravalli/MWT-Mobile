//
//  MWTPortfolioSingleton.h
//  MyWinningTradeStoryboarded
//
//  Created by Joseph Levin on 1/29/13.
//  Copyright (c) 2013 Conclave Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MWTPortfolioSingleton : NSObject
{
    NSString *someProperty;
}

@property (nonatomic, retain) NSString *someProperty;

+ (id) sharedInstance;

@end
