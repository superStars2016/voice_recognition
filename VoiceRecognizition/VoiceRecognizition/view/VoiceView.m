//
//  VoiceView.m
//  VoiceRecognitio
//
//  Created by lander on 16/6/2.
//  Copyright © 2016年 lander. All rights reserved.
//

#import "VoiceView.h"
#import "UIView+AutoLayout.h"
#import "langueButton.h"
#import "UIView+AutoLayout.h"
#define kDuration 0.8
static id singletonVoice;
@interface VoiceView()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet langueButton *langugeBtn;

@property (weak, nonatomic) IBOutlet UIButton *closeBtn;

- (IBAction)VoiceBtnUp:(UIButton *)sender;
- (IBAction)VoiceBtnDown:(UIButton *)sender;
- (IBAction)closeBtnClick:(id)sender;
- (IBAction)langugeBtnClicked:(id)sender;

@property(nonatomic,strong) UIPickerView *pickView;
@end
@implementation VoiceView
-(UIPickerView *)pickView{
    if (!_pickView) {
        _pickView=[[UIPickerView alloc]init];
        _pickView.backgroundColor=[UIColor grayColor];
        _pickView.delegate=self;
        _pickView.dataSource=self;
        _pickView.hidden=YES;
        
        [self addSubview:self.pickView];
        //[[[UIApplication sharedApplication].delegate window] addSubview:_pickView];

    }
    return _pickView;

}
/**
 *  从xib中创建
 */
-(void)awakeFromNib{
    
    
    [self.pickView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.pickView.superview];
    [self.pickView  autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.pickView.superview];
    [self.pickView  autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.pickView.superview];
    [self.pickView  autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.pickView.superview];
    //CGRect rect=self.bounds;
    //rect.size.height=200;
    //rect.size.width=self.superview.bounds.size.width;
    //self.bounds=rect;
    
    //self.hidden=YES;
}
/**
*  录制完毕
*
*  @param sender <#sender description#>
*/
- (IBAction)VoiceBtnUp:(UIButton *)sender {
    NSLog(@"录制完毕");
    
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
    
    self.langugeBtn.alpha=0.5;
    self.langugeBtn.enabled=NO;
    self.closeBtn.alpha=0.5;
    self.closeBtn.enabled=NO;
    
}

- (IBAction)closeBtnClick:(id)sender {
    
    [self dissMiss];
}

- (IBAction)langugeBtnClicked:(id)sender {
    self.pickView.hidden=NO;
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
    
//    CGFloat h=self.bounds.size.height;
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
//        [self removeFromSuperview];
    }];
    

}

#pragma mark pickViewDataSource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 3;

}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{

return @"都是中国人";
}
@end
