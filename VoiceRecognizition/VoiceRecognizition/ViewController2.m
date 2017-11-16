//
//  ViewController2.m
//  VoiceRecognizition
//
//  Created by naver on 16/8/22.
//  Copyright © 2016年 lander. All rights reserved.
//

#import "ViewController2.h"
#import <PureLayout/PureLayout.h>
#import "NDRecognizeResultTextView.h"

#import "NDResultViewController.h"
@interface ViewController2 ()

@property (nonatomic,strong) NDResultViewController *resultVC;
@property (nonatomic,strong) UIButton *newsReultBtn;
@end

@implementation ViewController2
- (void)loadView {
    self.view = [UIView new];
    self.view.backgroundColor = [UIColor colorWithWhite:0.1 alpha:1.0];
    
    UIButton *btn=[UIButton newAutoLayoutView];
    [self.view addSubview:btn];
    self.newsReultBtn=btn;
    [btn setTitle:@"sdfsdf"forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(getResults) forControlEvents:UIControlEventTouchUpInside ];
    
    
    self.resultVC=[[NDResultViewController alloc]init];
    [self addChildViewController:self.resultVC];
    
    [self.view addSubview:self.resultVC.view];
    
    [self.view setNeedsUpdateConstraints];
}
-(void)getResults{
    self.resultVC.resultDcit= @{
                                @"ocrs": @[
                                        @{
                                            @"text": @"您好好 ",
                                            @"LT": @{ @"x": @(47), @"y": @(6) },
                                            @"RT": @{ @"x": @(331),@"y": @(6) },
                                            @"RB": @{ @"x":@(331), @"y": @(29) },
                                            @"LB": @{ @"x": @(47), @"y": @(29) }
                                            }, @{
                                            @"text": @"HELPING BANGO LUF SEN ",
                                            @"LT": @{ @"x": @(43), @"y": @(33) },
                                            @"RT": @{ @"x": @(386), @"y": @(33) },
                                            @"RB": @{ @"x": @(385), @"y": @(54) },
                                            @"LB": @{ @"x": @(42), @"y": @(51) }
                                            }, @{
                                            @"text": @"HIT THE HIGH NOTES ",
                                            @"LT": @{ @"x": @(41), @"y": @(150) },
                                            @"RT": @{ @"x": @(302), @"y": @(150) },
                                            @"RB": @{ @"x": @(300), @"y": @(200) },
                                            @"LB": @{ @"x": @(39), @"y": @(200) }
                                            }
                                        ]
                                };
    


}
- (void)updateViewConstraints {
    [self.newsReultBtn autoPinEdgesToSuperviewEdges];
    
    [super updateViewConstraints];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.resultVC.resultDcit= @{
                           @"ocrs": @[
                                   @{
                                       @"text": @"How s geoff warns ",
                                       @"LT": @{ @"x": @(47), @"y": @(6) },
                                       @"RT": @{ @"x": @(331),@"y": @(6) },
                                       @"RB": @{ @"x":@(331), @"y": @(29) },
                                       @"LB": @{ @"x": @(47), @"y": @(29) }
                                       }, @{
                                       @"text": @"HELPING BANGO LUF SEN ",
                                       @"LT": @{ @"x": @(43), @"y": @(33) },
                                       @"RT": @{ @"x": @(386), @"y": @(33) },
                                       @"RB": @{ @"x": @(385), @"y": @(54) },
                                       @"LB": @{ @"x": @(42), @"y": @(51) }
                                       }, @{
                                       @"text": @"HIT THE HIGH NOTES ",
                                       @"LT": @{ @"x": @(41), @"y": @(150) },
                                       @"RT": @{ @"x": @(302), @"y": @(150) },
                                       @"RB": @{ @"x": @(300), @"y": @(200) },
                                       @"LB": @{ @"x": @(39), @"y": @(200) }
                                       }
                                   ]
                           };
    

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onDeviceOrientationChange) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)onDeviceOrientationChange
{
        UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
        switch (orientation) {
            case UIDeviceOrientationFaceUp:
                NSLog(@"屏幕朝上平躺");
                break;
                
            case UIDeviceOrientationFaceDown:
                NSLog(@"屏幕朝下平躺");
                break;
                
            case UIDeviceOrientationUnknown:
                NSLog(@"未知方向");
                break;
                
            case UIDeviceOrientationLandscapeLeft:
                NSLog(@"屏幕向左横置");
                [self rotateSubViews:M_PI_2 withDeviceOrientation:UIDeviceOrientationLandscapeLeft];
                break;
                
            case UIDeviceOrientationLandscapeRight:
                [self rotateSubViews:-M_PI_2 withDeviceOrientation:UIDeviceOrientationLandscapeRight];
                NSLog(@"屏幕向右橫置");
                break;
                
            case UIDeviceOrientationPortrait:
                [self rotateSubViews:0.0f withDeviceOrientation:UIDeviceOrientationPortrait];
                NSLog(@"屏幕直立");
                break;
                
            case UIDeviceOrientationPortraitUpsideDown:
                [self rotateSubViews:0.0f withDeviceOrientation:UIDeviceOrientationPortraitUpsideDown];
                NSLog(@"屏幕直立，上下顛倒");
                break;
                
            default:
                NSLog(@"无法辨识");
                break;
        }
    
}

- (void)rotateSubViews:(CGFloat)angle withDeviceOrientation:(UIDeviceOrientation)orientation{
    [self.resultVC  rotateViews:angle withDeviceOrientation:orientation];

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

@end
