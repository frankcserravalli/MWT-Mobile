//
//  MWTSearchResult.h
//  MyWinningTradeStoryboarded
//
//  Created by Joseph Levin on 6/4/13.
//  Copyright (c) 2013 Conclave Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MWTSearchResult : NSObject

@property (strong, nonatomic) NSString *symbol;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *exch;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *exchDisp;
@property (strong, nonatomic) NSString *typeDisp;

- (id) initWith:(NSDictionary *)dictionary;

@end
