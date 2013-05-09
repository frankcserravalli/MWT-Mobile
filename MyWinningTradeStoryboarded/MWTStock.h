//
//  MWTStock.h
//  MyWinningTradeStoryboarded
//
//  Created by Joseph Levin on 1/23/13.
//  Copyright (c) 2013 Conclave Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface MWTStock : NSObject

//@property (strong, nonatomic) NSDictionary *stockDetails;
//
//-(void)getStockDetailsForStock:(NSString *)symbol;
//-(void)parseStock:(NSData *)data;


@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *symbol;
@property (strong, nonatomic) NSNumber *current_price;
@property (strong, nonatomic) NSNumber *shares_owned;
@property (strong, nonatomic) NSNumber *current_value;
@property (strong, nonatomic) NSNumber *cost_basis;
@property (strong, nonatomic) NSNumber *capital_gain;
@property (strong, nonatomic) NSNumber *percent_gain;

- (id) initWith:(NSDictionary *)dictionary;

@end
