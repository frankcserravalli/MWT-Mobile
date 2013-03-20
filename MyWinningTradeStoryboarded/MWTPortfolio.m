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
        _shouldParsePortfolio = FALSE;
        _shouldParsePendingStopLoss = FALSE;
        _shouldParsePendingDateTime = FALSE;
        
        [self getPortfolio];
    }
    
    return self;
}

#pragma mark - Data Retrieval

- (void) getPortfolio
{
    _shouldParsePortfolio = TRUE;
    
    NSInteger user_id = [[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"] intValue];
    NSString *ios_token = [[NSUserDefaults standardUserDefaults] objectForKey:@"ios_token"];
    
    NSString *portfolioURLString = [NSString stringWithFormat:@"%@/api/v1/users/portfolio", serverURL];
    NSURL *portfolioURL = [NSURL URLWithString:portfolioURLString];
    NSString *bodyString = [NSString stringWithFormat:@"user_id=%i&ios_token=%@", user_id, ios_token];
    
    double timeOutInterval = 60.0;
    
    NSMutableData *POSTData = [NSMutableData data];
    [POSTData appendData:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
    NSString *POSTLength = [NSString stringWithFormat:@"%d", [POSTData length]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:portfolioURL
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:timeOutInterval];
    [request setHTTPMethod:@"POST"];
    [request setValue:POSTLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:POSTData];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];

//    NSURL *portfolioURL = [NSURL URLWithString:portfolioURLString];
//    
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:portfolioURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
//    [request setHTTPMethod:@"GET"];
//   
//    NSError *requestError;
//    
//    NSURLResponse *urlResponse = nil;
//    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
//    
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

}

- (void) getPendingDateTimePositions
{
    int user_id = 1;
    
    NSString *pendingDateTimeTransactionsURLString = [NSString stringWithFormat:@"%@/api/v1/users/pending_date_time_transactions?user_id=%i", serverURL, user_id];
    
    NSURL *pendingDateTimeTransactionsURL = [NSURL URLWithString:pendingDateTimeTransactionsURLString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:pendingDateTimeTransactionsURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    NSError *requestError;
    
    NSURLResponse *urlResponse = nil;
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    [self parsePendingDateTimePositions:response];
}

- (void) getPendingStopLossPositions
{
    int user_id = 1;
    
    NSString *pendingDateTimeTransactionsURLString = [NSString stringWithFormat:@"http://%@/api/v1/users/pending_stop_loss_transactions?user_id=%i", serverURL, user_id];
    
    NSURL *pendingDateTimeTransactionsURL = [NSURL URLWithString:pendingDateTimeTransactionsURLString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:pendingDateTimeTransactionsURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    NSError *requestError;
    
    NSURLResponse *urlResponse = nil;
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    [self parsePendingStopLossPositions:response];
}

- (void) parsePendingDateTimePositions:(NSData *)data
{
//    [self returnTypeOfJSONfrom:data];
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSArray *pending = [parser objectWithData:data];
    
    [self parseJSON:pending];
}

- (void) parsePendingStopLossPositions:(NSData *)data
{
    
}

- (void) parsePortfolio:(NSData *)data
{
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *portfolio = [parser objectWithData:data];
    
    [self assignValuesFrom:portfolio];
}

- (void) assignValuesFrom:(NSDictionary *)dictionary
{
    NSLog(@"Assigning values");
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

- (void) parseJSON:(NSArray *)array
{
    NSDictionary *dict = [array objectAtIndex:1];
    [self displayDictionary:dict];
}

- (NSDictionary *) retrieveDictFromJSON:(NSArray *)array At:(NSInteger)index
{
    return [array objectAtIndex:index];
}

- (NSDictionary *)getStockDictionaryFromStock:(NSString *)stockSymbol
{
    return [_stocks objectForKey:stockSymbol];
}

- (void) displayDictionary:(NSDictionary *)dictionary
{
    for (NSString *key in dictionary)
    {
        NSLog(@"Key: %@", key);
        NSLog(@"Values: %@", [dictionary objectForKey:key]);
    }
}

- (void) returnTypeOfJSONfrom:(NSData *)data
{
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    id result = [parser objectWithData:data];
    if ([result isKindOfClass:[NSArray class]])
    {
        NSLog(@"NSArray");
        NSArray *array = (NSArray *)result;
        for (int i = 0; i < array.count ; i++)
        {
            NSLog(@"%@", array[i]);
        }
    }
    else if ([result isKindOfClass: [NSDictionary class]])
    {
        NSLog(@"NSDictionary");
    }
}

- (NSArray *) sortArrayOf:(NSMutableArray *)stocks by:(NSString *)key ascending:(BOOL)ascending
{
    return [stocks sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:key ascending:ascending]]];
}

- (NSArray *) convertIntoArrayADictOf:(NSDictionary *)stocks
{
    NSMutableArray *stocksArray = [[NSMutableArray alloc] init];
    
    for (NSString *stockName in stocks)
    {
        NSDictionary *stockDict = [self getStockDictionaryFromStock:stockName];
        NSMutableDictionary *mutableStockDict = [[NSMutableDictionary alloc] initWithDictionary:stockDict];
        [mutableStockDict setObject:stockName forKey:@"symbol"];
        [stocksArray addObject:mutableStockDict];
    }
    
    return stocksArray;
}

- (void) displayStocksArraySortedBy:(NSString *)key
{
    _stocksArray = [[NSArray alloc] initWithArray:[self convertIntoArrayADictOf:_stocks]];
    _stocksArray = [self sortArrayOf:_stocksArray by:key ascending:NO];
    
    for (int i = 0; i < _stocksArray.count; i++)
    {
        NSDictionary *stockAtIndex = [_stocksArray objectAtIndex:i];
        NSString *logString = [stockAtIndex objectForKey:@"symbol"];
        NSLog(logString);
    }
}

- (void) sortStocksBasedOn:(NSString *)key
{
    _stocksArray = [[NSArray alloc] initWithArray:[self convertIntoArrayADictOf:_stocks]];
    
    if ([key isEqualToString:@"symbol"])
    {
        _stocksArray = [self sortArrayOf:_stocksArray by:key ascending:YES];

    }
    else
    {
        _stocksArray = [self sortArrayOf:_stocksArray by:key ascending:NO];
    }

    NSMutableArray *sortedSymbolsArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < _stocksArray.count; i++)
    {
        NSDictionary *stockAtIndex = [_stocksArray objectAtIndex:i];
        NSString *symbol = [stockAtIndex objectForKey:@"symbol"];
        [sortedSymbolsArray addObject:symbol];
    }
    
    _stockSymbols = sortedSymbolsArray;
}

#pragma mark - NSURLConnection Delegate Methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    _responseData = [[NSMutableData alloc] init];
    [_responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    _responseData = nil;
    NSLog(@"Connection failed, error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
    
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"Connection successful! Received %d bytes of data", _responseData.length);
    NSString *responseString = [[NSString alloc] initWithData:_responseData encoding:NSASCIIStringEncoding];
    NSLog(responseString);
    
    if (responseString.length > 30)
    {
        if (_shouldParsePortfolio)
        {
            _shouldParsePortfolio = FALSE;
            [self parsePortfolio:_responseData];
        }
        else if (_shouldParsePendingDateTime)
        {
            _shouldParsePendingDateTime = FALSE;
            [self parsePendingDateTimePositions:_responseData];
        }
        else if (_shouldParsePendingStopLoss)
        {
            _shouldParsePendingStopLoss = FALSE;
            [self parsePendingStopLossPositions:_responseData];
        }
    }
    else
    {
        NSLog(@"Authentication unsuccessful");
    }
}

#pragma mark - JSON
- (NSDictionary *)receiveJSON
{
    NSError *JSONError = nil;
    id JSONObject = [NSJSONSerialization JSONObjectWithData:_responseData options:kNilOptions error:&JSONError];
    
    if ([JSONObject isKindOfClass:[NSArray class]])
    {
        NSArray *JSONArray = (NSArray *)JSONObject;
        return [NSDictionary dictionaryWithObject:JSONArray forKey:@"JSONArray"];
    }
    else
    {
        NSDictionary *JSONDictionary = (NSDictionary *)JSONObject;
        return JSONDictionary;
    }
}

@end
