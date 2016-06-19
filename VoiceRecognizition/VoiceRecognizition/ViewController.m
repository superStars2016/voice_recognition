//
//  ViewController.m
//  VoiceRecognizition
//
//  Created by lander on 16/6/20.
//  Copyright © 2016年 lander. All rights reserved.
//

#import "ViewController.h"
#import "VoiceView.h"
#import "UIView+AutoLayout.h"
@interface ViewController (){
    VoiceView *_voice;

}
- (IBAction)show:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    VoiceView *voice=[VoiceView sharedVoiceView];
    [self.view addSubview:voice];
    voice.hidden=YES;
    [voice autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:voice.superview];
    [voice autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:voice.superview];
    [voice autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:voice.superview];
    [voice autoSetDimension:ALDimensionHeight toSize:200];
    _voice=voice;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)show:(id)sender {
    _voice.hidden=NO;
    
}
@end
