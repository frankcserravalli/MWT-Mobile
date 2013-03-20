//
//  MWTStockChartViewController.h
//  MyWinningTradeStoryboarded
//
//  Created by Joseph Levin on 3/20/13.
//  Copyright (c) 2013 Conclave Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MWTStockChartViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIWebView *webView;

@property (strong, nonatomic) NSString *stockSymbol;

@end
