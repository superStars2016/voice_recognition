//
//  ViewController.m
//  VoiceRecognitio
//
//  Created by lander on 16/6/2.
//  Copyright © 2016年 lander. All rights reserved.
//

#import "ViewController.h"
#import "VoiceView.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "VoiceWebJsCore.h"
#import "UIView+AutoLayout.h"
@interface ViewController ()<VoiceWebJsCoreDelegate,VoiceViewDelegate>{
    JSContext *_context;
    
}
@property (weak, nonatomic) IBOutlet UIButton *button;
- (IBAction)btnClickShow:(id)sender;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property(strong,nonatomic) VoiceView *voiceView;


@property(strong,nonatomic) UIView * coverView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.button setTitle:NSLocalizedString(@"title", nil) forState:UIControlStateNormal];
    
    self.coverView=[[UIView alloc]init];
    self.coverView.backgroundColor=[UIColor blackColor];
    self.coverView.hidden=YES;
    [self.view addSubview:_coverView];
    
    [self.coverView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.coverView.superview];
    [self.coverView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.coverView.superview];
    [self.coverView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.coverView.superview];
    [self.coverView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.coverView.superview];
    
    VoiceView *voice=[VoiceView sharedVoiceView];
    _voiceView=voice;
    voice.delegate=self;
    [self.view addSubview:voice];
    // voice.frame=CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 200);
    //[voice autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [voice autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:voice.superview];
    [voice autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:voice.superview];
    [voice autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:voice.superview];
    [voice autoSetDimension:ALDimensionHeight toSize:285];
    
    [voice layoutIfNeeded];//这句代码是让layout立即布局
   
    
    //[self performSelector:@selector(ends) withObject:nil afterDelay:3];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    self.webView.backgroundColor=[UIColor clearColor];
    self.webView.opaque=NO;
    self.webView.backgroundColor=[UIColor grayColor];
    

    
}
-(void)ends{
    NSString *alertJSs=@"jscore.dissMissVoiceView()"; //准备执行的js代码
    [_context evaluateScript:alertJSs];
}
-(void)showVoiceView{
    self.coverView.hidden=NO;
    self.coverView.alpha=0.5;
    [_voiceView show];
    
    
}
-(void)VoiceViewDismissed:(VoiceView *)voiceView{
    self.coverView.hidden=YES;
    self.coverView.alpha=0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnClickShow:(id)sender {
    //注册jsCore
    _context=[self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    VoiceWebJsCore *webJsCore= [[VoiceWebJsCore alloc] init];
    webJsCore.delegate=self;
    _context[@"jscore"]=webJsCore;
    NSString *alertJS=@"jscore.showVoiceView()"; //准备执行的js代码
    [_context evaluateScript:alertJS];
}
@end
