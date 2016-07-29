//
//  VoiceView.m
//  VoiceRecognitio
//
//  Created by lander on 16/6/2.
//  Copyright © 2016年 lander. All rights reserved.
// 自定义voiceView

#import "VoiceView.h"
#import "UIView+AutoLayout.h"
#import "langueButton.h"
#import "UIView+AutoLayout.h"
#import "langugePickView.h"
#define kDuration 0.8
static id singletonVoice;
@interface VoiceView()<langugePickViewDelegate>{
    NSString *_languge;     //选择的语言
    NSString *_langugeCode; //选择的语音对应code
    
    BOOL _showCircle;
    
    CGFloat _radios;
    //NSTimer *_timer;
}

@property (weak, nonatomic) IBOutlet UIButton *voiceBtn;
@property (weak, nonatomic) IBOutlet langueButton *langugeBtn;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (weak, nonatomic) IBOutlet UILabel *inforLabel;
@property(nonatomic,strong) NSDictionary *languageDict;

- (IBAction)VoiceBtnUp:(UIButton *)sender;
- (IBAction)VoiceBtnDown:(UIButton *)sender;
- (IBAction)closeBtnClick:(id)sender;
- (IBAction)langugeBtnClicked:(id)sender;

@property(nonatomic,strong) langugePickView *langugeView;
@end
@implementation VoiceView
-(NSDictionary *)languageDict{
    if (!_languageDict) {
        _languageDict=@{@"한국어":@"han",@"영어":@"english",@"일본어":@"jarpan",@"중국어":@"china"};
    
    }
    return _languageDict;
}
/**
 *  从xib中创建
 */
-(void)awakeFromNib{
    langugePickView *langugeView=[langugePickView sharedInstance];
    langugeView.delegate=self;
    _langugeView=langugeView;
    [self addSubview:langugeView];
 
    [langugeView  autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:langugeView.superview];
    [langugeView  autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:langugeView.superview];
    [langugeView  autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:langugeView.superview];
    [langugeView  autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:langugeView.superview];
}
/**
*  录制完毕
*
*  @param sender <#sender description#>
*/
- (IBAction)VoiceBtnUp:(UIButton *)sender {
    NSLog(@"录制完毕");
    //0.设置关闭和选择按钮的状态-可用
    [self enabledButtons];
     _showCircle=NO;
    [self setNeedsDisplay];
    
    
  
}
-(void)enabledButtons{
    self.langugeBtn.alpha=1;
    self.langugeBtn.enabled=YES;
    self.closeBtn.alpha=1;
    self.closeBtn.enabled=YES;
}
/**
 *  开始录制
 *
 *  @param sender <#sender description#>
 */
- (IBAction)VoiceBtnDown:(UIButton *)sender {
    NSLog(@"开始录制");
    //0.设置关闭 和选择语言按钮的状态-不可用
    [self disabledBtns];
  
 
    //[self performSelectorOnMainThread:@selector(beginCircle) withObject:nil waitUntilDone:NO];
_showCircle=YES;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self beginCircle1];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self beginCircle2];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self beginCircle3];
    });
}
-(void)beginCircle1{
    
    self.inforLabel.text=@"어한국어";
        _radios=51;
         [self setNeedsDisplay];
        
    
    

}
-(void)beginCircle2{
    
    //self.inforLabel.text=@"어한국어어한국어어한국어어한국어어한국어";
    _radios=120;
    [self setNeedsDisplay];
    
    
    
    
}
-(void)beginCircle3{
    
    
    _radios=69;
    [self setNeedsDisplay];
    
    
    
    
}
-(void)disabledBtns{
    self.langugeBtn.alpha=0.5;
    self.langugeBtn.enabled=NO;
    self.closeBtn.alpha=0.5;
    self.closeBtn.enabled=NO;
}
- (IBAction)closeBtnClick:(id)sender {
    [self dissMiss];
}

- (IBAction)langugeBtnClicked:(id)sender {
    [self.langugeView show];
}

/**
 *  获取voiceView实例
 *
 *  @return <#return value description#>
 */
+(instancetype)sharedVoiceView{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singletonVoice=[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil][0];
    });
    return singletonVoice ;
}
-(void)show{
    self.hidden=NO;
    
    [UIView animateWithDuration:kDuration animations:^{
        self.transform=CGAffineTransformMakeTranslation(0, -self.bounds.size.height);
        //[self layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
    }];
}
-(void)dissMiss{
    [UIView animateWithDuration:kDuration animations:^{
        self.transform=CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        self.hidden=YES;
    }];
    if ([self.delegate respondsToSelector:@selector(VoiceViewDismissed:)]) {
        [self.delegate VoiceViewDismissed:self];
    }
}
#pragma mark langugePickView Delegate
-(void)langugePickView:(langugePickView *)langugePickView didSelectLangeue:(NSString *)languegeString langueCode:(NSString *)langueCode{
    if (langueCode && languegeString) {
        _languge=languegeString;
        _langugeCode=langueCode;
        [self.langugeBtn setTitle:languegeString forState:UIControlStateNormal];
    }
}

-(void)drawRect:(CGRect)rect{
    if (_showCircle) {
        CGContextRef cr = UIGraphicsGetCurrentContext();
        
        //先是根据调用者的位置计算中心点
        CGPoint center=self.voiceBtn.center;
        //然后可以根据rect大小计算圆半径 使其充满圆
        float maxRadius =_radios; //hypot(bounds.size.width, bounds.size.height)/2; 最小59 最大130
        //设置线条宽度
        CGContextSetLineWidth(cr, 1);
        //设置线条颜色
        [[UIColor lightGrayColor] setStroke];
         [[UIColor lightGrayColor] setFill];
        //把参数加入到上下文
        CGContextAddArc(cr, center.x, center.y, maxRadius, 0.0, M_PI * 2.0, YES);
        //执行绘图，绘图后把路径移除
        //CGContextStrokePath(cr);
       
        CGContextFillPath(cr);
    }
    
}
@end
