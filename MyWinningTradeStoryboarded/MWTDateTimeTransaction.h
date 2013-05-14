//
//  MWTDateTimeTransaction.h
//  MyWinningTradeStoryboarded
//
//  Created by Joseph Levin on 5/14/13.
//  Copyright (c) 2013 Conclave Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MWTDateTimeTransaction : NSObject

@property (strong, nonatomic) NSString *created_at;
@property (strong, nonatomic) NSString *execute_at;
@property (strong, nonatomic) NSNumber *transaction_id;
@property (strong, nonatomic) NSString *order_type;
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSString *updated_at;
@property (strong, nonatomic) NSNumber *user_id;
@property (strong, nonatomic) NSNumber *user_stock_id;
@property (strong, nonatomic) NSNumber *volume;

- (id) initWith:(NSDictionary *)dictionary;

@end
