//
//  MWTStock.h
//  MyWinningTradeStoryboarded
//
//  Created by Joseph Levin on 1/23/13.
//  Copyright (c) 2013 Conclave Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBJson.h"

@interface MWTStock : NSObject

@property (strong, nonatomic) NSDictionary *stockDetails;

-(void)getStockDetailsForStock:(NSString *)symbol;
-(void)parseStock:(NSData *)data;

@end
