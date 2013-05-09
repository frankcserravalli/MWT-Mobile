//
//  MWTAPIClient.m
//  MyWinningTradeStoryboarded
//
//  Created by Joseph Levin on 5/7/13.
//  Copyright (c) 2013 Conclave Labs. All rights reserved.
//

#import "MWTAPIClient.h"

@implementation MWTAPIClient

+ (id) sharedInstance
{
    static MWTAPIClient *__sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[MWTAPIClient alloc] initWithBaseURL:[NSURL URLWithString:serverURL]];
    });
    
    return __sharedInstance;
}

- (id) initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self)
    {
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self setDefaultHeader:@"Accept" value:@"application/json"];
        self.parameterEncoding = AFJSONParameterEncoding;
    }
    
    return self;
}

@end
