//
//  MWTShort.h
//  MyWinningTradeStoryboarded
//
//  Created by Joseph Levin on 5/14/13.
//  Copyright (c) 2013 Conclave Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MWTShort : NSObject

@property (strong, nonatomic) NSString *capital_gain;
@property (strong, nonatomic) NSString *cost_basis;
@property (strong, nonatomic) NSString *current_price;
@property (strong, nonatomic) NSString *current_value;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSNumber *percent_gain;
@property (strong, nonatomic) NSNumber *shares_owned;
@property (strong, nonatomic) NSString *symbol;

- (id) initWith:(NSDictionary *)dictionary;

@end
