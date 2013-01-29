//
//  MWTPortfolioSingleton.m
//  MyWinningTradeStoryboarded
//
//  Created by Joseph Levin on 1/29/13.
//  Copyright (c) 2013 Conclave Labs. All rights reserved.
//

#import "MWTPortfolioSingleton.h"

@implementation MWTPortfolioSingleton

#pragma mark Singleton Methods

+ (id) sharedInstance
{
    static MWTPortfolioSingleton *sharedPortfolioSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedPortfolioSingleton = [[self alloc] init];
    });
    return sharedPortfolioSingleton;
}

-(id)init
{
    if (self = [super init])
    {
        //Initialization
        _userPortfolio = [[MWTPortfolio alloc] init];
    }
    return self;
}

-(void)dealloc
{
    // Should never be called
}

@end
