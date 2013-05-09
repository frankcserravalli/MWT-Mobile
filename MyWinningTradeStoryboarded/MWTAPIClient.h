//
//  MWTAPIClient.h
//  MyWinningTradeStoryboarded
//
//  Created by Joseph Levin on 5/7/13.
//  Copyright (c) 2013 Conclave Labs. All rights reserved.
//

#import "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"

@interface MWTAPIClient : AFHTTPClient

+ (id) sharedInstance;

@end
