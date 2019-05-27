//
//  ViewController.m
//  webView-webp
//
//  Created by My-PC on 27/5/2019.
//  Copyright © 2019 YJ. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import "BAWKWebView_WebP.h"

static NSString * const kWebpURL = @"http://www.etherdream.com/WebP/";
#define kScreenH [UIScreen mainScreen].bounds.size.height //屏幕高度
#define kScreenW [UIScreen mainScreen].bounds.size.width //屏幕宽度


@interface ViewController ()
@property(nonatomic,strong) WKWebView *webView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI
{
    [self.view setBackgroundColor:[UIColor blueColor]];
    [self ba_registerURLProtocol];
    [self.view addSubview:self.webView];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:kWebpURL]]];
}

#pragma mark - 注册自定义 NSURLProtocol
- (void)ba_registerURLProtocol
{
    [NSURLProtocol registerClass:NSClassFromString(@"BAURLSessionProtocol")];
    // 注册registerScheme使得WKWebView支持NSURLProtocol
    [NSURLProtocol ba_web_registerScheme:@"http"];
    [NSURLProtocol ba_web_registerScheme:@"https"];
}

- (void)dealloc
{
    [NSURLProtocol unregisterClass:NSClassFromString(@"BAURLSessionProtocol")];
    // 移除 registerScheme
    [NSURLProtocol ba_web_unregisterScheme:@"http"];
    [NSURLProtocol ba_web_unregisterScheme:@"https"];
}

- (WKWebView *)webView
{
    if (!_webView)
    {
        _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    }
    return _webView;
}
@end
