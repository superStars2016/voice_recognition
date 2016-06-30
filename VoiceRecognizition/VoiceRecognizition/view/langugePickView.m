//
//  langugePickView.m
//  VoiceRecognizition
//
//  Created by lander on 16/6/28.
//  Copyright © 2016年 lander. All rights reserved.
//自定义语音选择view

#import "langugePickView.h"
@interface langugePickView()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
/** 取消选择语言 */
- (IBAction)cancelBtnClicked:(id)sender;
/** 完成选择语言 */
- (IBAction)finishBtnClicked:(id)sender;

/** 语言字典 */
@property(nonatomic,strong) NSDictionary *languageDict;
/** 语音数组 */
@property(nonatomic,strong) NSArray *languageArray;
@end
@implementation langugePickView
#pragma mark 懒加载数据
-(NSArray *)languageArray{
    if (!_languageArray) {
        _languageArray=@[@"한국어",@"영어",@"일본어",@"중국어"];
    }
    return _languageArray;
}
-(NSDictionary *)languageDict{
    if (!_languageDict) {
        _languageDict=@{@"한국어":@"han",@"영어":@"english",@"일본어":@"jarpan",@"중국어":@"china"};
        
    }
    return _languageDict;
}
/**
 *  从xib中唤醒
 */
-(void)awakeFromNib{
    self.pickerView.delegate=self;   //设置uiPickView代理和数据源
    self.pickerView.dataSource=self;
    self.hidden=YES;

}
/**
 *  获取选择view实例
 *
 *  @return <#return value description#>
 */
+(instancetype)sharedInstance{

    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil][0];

}
#pragma mark 取消 和完成 语言选择
/**
 *  点击了取消
 *
 *  @param sender <#sender description#>
 */
- (IBAction)cancelBtnClicked:(id)sender {
    [self hide];
}
/**
 *  完成语言选择
 *
 *  @param sender <#sender description#>
 */
- (IBAction)finishBtnClicked:(id)sender {
    [self hide];
    
    if ([self.delegate respondsToSelector:@selector(langugePickView:didSelectLangeue:langueCode:)]) {
        
        NSInteger row=[self.pickerView selectedRowInComponent:0];
        NSString *langugeCode=[self.languageDict valueForKey:self.languageArray[row]];
        
        [self.delegate langugePickView:self didSelectLangeue:self.languageArray[row] langueCode:langugeCode];
    }
}
#pragma mark view的显示和隐藏
-(void)show{
    self.hidden=NO;
    self.alpha=0.6;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha=1;
    }];
}
-(void)hide{
    self.alpha=1;
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha=0.0;
    } completion:^(BOOL finished) {
        self.hidden=YES;
    }];

}

#pragma mark pickViewDataSource
//多少列不能省掉
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
//多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.languageArray.count;
    
}
//每行显示什么内容
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.languageArray[row];
}
@end
