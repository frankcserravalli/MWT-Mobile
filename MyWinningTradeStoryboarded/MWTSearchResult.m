//
//  MWTSearchResult.m
//  MyWinningTradeStoryboarded
//
//  Created by Joseph Levin on 6/4/13.
//  Copyright (c) 2013 Conclave Labs. All rights reserved.
//

#import "MWTSearchResult.h"

@implementation MWTSearchResult

- (id) initWith:(NSDictionary *)dictionary
{
    self = [super init];
    
    if (self)
    {
        self.symbol = [dictionary objectForKey:@"symbol"];
        self.name = [dictionary objectForKey:@"name"];
        self.exch = [dictionary objectForKey:@"exch"];
        self.type = [dictionary objectForKey:@"type"];
        self.exchDisp = [dictionary objectForKey:@"exchDisp"];
        self.typeDisp = [dictionary objectForKey:@"typeDisp"];
    }
    
    return self;
}


@end
