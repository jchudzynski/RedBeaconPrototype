//
//  WebViewController.h
//  RedBeaconPrototype
//
//  Created by DJ Mobile Inc on 3/3/13.
//  Copyright (c) 2013 DJ Mobile Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *mainTitle;
@property (strong, nonatomic) NSString * url;
@property (strong, nonatomic) NSString * htmlString;
@property (strong, nonatomic) NSString * videoURL;
@property (strong, nonatomic) IBOutlet UIWebView *webview;

@end
