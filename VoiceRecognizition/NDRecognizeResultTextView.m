//
//  NDSingleResultView.m
//  naverdicapp
//
//  Created by naver on 16/8/19.
//  Copyright © 2016年 Naver_China. All rights reserved.
//

#import "NDRecognizeResultTextView.h"
#import "NDTextAttcahment.h"
#define HEX_COLOR(c,a)          \
[UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:(a)]
#define UIColorWithRGB(r, g, b) \
[UIColor colorWithRed:1.0*(r)/0xff green:1.0*(g)/0xff blue:1.0*(b)/0xff alpha:1.0]

#define IS_IOS9_OR_HEIGHER      \
(([[UIDevice currentDevice].systemVersion floatValue] >=9.0) ? YES:NO)

#define IS_HEIGHER_Version(version)     \
(([[UIDevice currentDevice].systemVersion floatValue] >=(version)) ? YES:NO)
@interface  NDRecognizeResultTextView()<UITextViewDelegate>{
    
    BOOL _isPlayOnTTS;
}
@end
@implementation NDRecognizeResultTextView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.delegate=self;
        self.scrollEnabled=NO;
        self.editable=NO;
        self.selectable=YES;
        self.dataDetectorTypes=UIDataDetectorTypeLink;
        self.linkTextAttributes = @{NSForegroundColorAttributeName: HEX_COLOR(0x00CD3E, 1.0)}; //设置超链接 属性样式
        self.textAlignment=NSTextAlignmentLeft ;
        self.backgroundColor=[UIColor greenColor];
        self.textContainerInset = UIEdgeInsetsMake(2.5, -5, 1, 0);
    }
    return self;

}

-(void)setSingleResultText:(NSString *)singleResultText{
    _singleResultText=singleResultText;
    
    self.attributedText=[self stringWithImage:_singleResultText];
}

-(NSMutableAttributedString *)stringWithImage:(NSString *)contentStr{
    // 创建一个富文本
    NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:contentStr];
    //设置字体
    [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17.0f] range:NSMakeRange(0, contentStr.length)];
    //设置超链接
    NSURL *url=[NSURL URLWithString:@"ReturnTranslateResultToWeb://"];
    [attriStr addAttribute:NSLinkAttributeName value:url range:NSMakeRange(0, contentStr.length)];

    // 创建图片附件
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    // 图片
    attch.image = [UIImage imageNamed:!_isPlayOnTTS?@"speack_btn":@"speack_btn_on"];
    // 设置图片大小
    attch.bounds = CGRectMake(100, -3, 18, 17.5);
    //attch.bounds = CGRectMake(0, 0, 15, 13);

    // 创建带有图片的富文本
    NSAttributedString *imgString = [NSAttributedString attributedStringWithAttachment:attch];
    [attriStr appendAttributedString:imgString];
    
    NSMutableParagraphStyle *
    style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.lineSpacing = 8;//增加行高
    style.headIndent = 0;//头部缩进，相当于左padding
    style.tailIndent = 0;//相当于右padding
    style.lineHeightMultiple = 1.0;//行间距是多少倍
    style.alignment = NSTextAlignmentLeft;//对齐方式
    style.firstLineHeadIndent = 0;//首行头缩进
    style.paragraphSpacing = 0;//段落后面的间距
    style.paragraphSpacingBefore = 0;//段落之前的间距
    [attriStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, contentStr.length)];

    return [attriStr copy];
}

#pragma mark TextViewDelegate
/**
 *  点击textView中的链接调用此代理
 *
 *  @param textView       textView
 *  @param URL            NSURL
 *  @param characterRange <#characterRange description#>
 *
 *  @return <#return value description#>
 */
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    if ([[URL scheme] isEqualToString:@"ReturnTranslateResultToWeb"]) {
            NSLog(@"点击了翻译结果-回调js返回结果");
        
          if([self.RecognizeResultTextViewDelegate respondsToSelector:@selector(RecognizeResultTextViewClickedTypeLinks:resultString:)]){
              [self.RecognizeResultTextViewDelegate RecognizeResultTextViewClickedTypeLinks:self resultString:self.singleResultText];
          }
            return NO;
        }
        return YES;

}
/**
 *  点击图片等附件触发代理
 *
 *  @param textView       textview
 *  @param textAttachment 附件
 *  @param characterRange
 *
 *  @return
 */
-(BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange{
    _isPlayOnTTS = !_isPlayOnTTS;
    self.singleResultText=_singleResultText;
    NSLog(@"点击了播放声音喇叭，调用tts播放声音~");
    
    if([self.RecognizeResultTextViewDelegate respondsToSelector:@selector(RecognizeResultTextViewPlaySoundOnTTS:)]){
        BOOL result=  [self.RecognizeResultTextViewDelegate RecognizeResultTextViewPlaySoundOnTTS:self];
        if (result) {
            _isPlayOnTTS=NO;
             self.singleResultText=_singleResultText;
        }
        
    }
    return NO;
}

#pragma mark 不显示copy,cut,菜单
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return NO;
}
@end
