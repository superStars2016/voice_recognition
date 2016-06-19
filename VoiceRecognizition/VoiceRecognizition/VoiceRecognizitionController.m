//
//  VoiceRecognizitionController.m
//  VoiceRecognizition
//
//  Created by lander on 16/6/20.
//  Copyright © 2016年 lander. All rights reserved.
//

#import "VoiceRecognizitionController.h"
#import "VoiceView.h"
@interface VoiceRecognizitionController ()
- (IBAction)setNeedDisplay:(id)sender;
@property (weak, nonatomic) IBOutlet VoiceView *displayView;

@end

@implementation VoiceRecognizitionController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)setNeedDisplay:(id)sender {
    [self.displayView setNeedsDisplay];
}
@end
