//
//  MWTPortfolio.m
//  MyWinningTradeStoryboarded
//
//  Created by Joseph Levin on 1/23/13.
//  Copyright (c) 2013 Conclave Labs. All rights reserved.
//

#warning NEEDS REFACTORING

#import "MWTPortfolio.h"
#import "SBJson.h"

@implementation MWTPortfolio

- (id)init
{
    self = [super init];
    
    if (self)
    {
        [self getPortfolio];
    }
    
    return self;
}

- (void) getPortfolio
{
    int user_id = 1;
    
    NSString *portfolioURLString = [NSString stringWithFormat:@"http://%@/api/v1/users/portfolio?user_id=%i", serverURL, user_id];
    NSURL *portfolioURL = [NSURL URLWithString:portfolioURLString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:portfolioURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod:@"GET"];
   
    NSError *requestError;
    
    NSURLResponse *urlResponse = nil;
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    
//    if (response == nil)
//    {
//        if (requestError != nil)
//        {
//            NSLog(@"I have an error");
//        }
//    }
//    else
//    {
//        [self parsePortfolio:response];
//    }
        [self parsePortfolio:response];

}

- (void) parsePortfolio:(NSData *)data
{
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *portfolio = [parser objectWithData:data];
    
    [self assignValuesFrom:portfolio];
}

- (void) assignValuesFrom:(NSDictionary *)dictionary
{
    _account_value = [dictionary objectForKey:@"account_value"];
    _cash = [dictionary objectForKey:@"cash"];
    _current_value = [dictionary objectForKey:@"current_value"];
    _percent_gain = [dictionary objectForKey:@"percent_gain"];
    _purchase_value = [dictionary objectForKey:@"purchase_value"];
    
    _pending_date_time_transactions = [dictionary objectForKey:@"pending_date_time_transactions"];
    _processed_date_time_transactions = [dictionary objectForKey:@"processed_date_time_transactions"];
    
    _pending_stop_loss_transactions = [dictionary objectForKey:@"pending_stop_loss_transactions"];
    _processed_stop_loss_transactions = [dictionary objectForKey:@"processed_stop_loss_transactions"];
    
    _shorts = [dictionary objectForKey:@"shorts"];
    
    _stocks = [dictionary objectForKey:@"stocks"];
    _stockSymbols = [[dictionary objectForKey:@"stocks"] allKeys];
}

- (NSDictionary *)getStockDictionaryFromStock:(NSString *)stockSymbol
{
    return [_stocks objectForKey:stockSymbol];
}

@end
