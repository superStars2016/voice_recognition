//
//  NDSingleResultView.h
//  naverdicapp
//
//  Created by naver on 16/8/19.
//  Copyright © 2016年 Naver_China. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  NDRecognizeResultTextView;
@protocol NDRecognizeResultTextViewDelegate<NSObject>
@optional
/**
 *  点击了textView上的超链接 返回结果给web
 *
 *  @param RecognizeResultTextView textiew
 *  @param resulatString           翻译结果一并返回
 */
-(void)RecognizeResultTextViewClickedTypeLinks:(NDRecognizeResultTextView *)RecognizeResultTextView  resultString:(NSString *)resulatString;


/**
 *  点击了后面的小喇叭
 *
 *  @param RecognizeResultTextView textView
 *
 *  @return 返回值
 */
-(BOOL)RecognizeResultTextViewPlaySoundOnTTS:(NDRecognizeResultTextView *)RecognizeResultTextView;

@end

@interface NDRecognizeResultTextView : UITextView

@property (nonatomic,strong) NSString *singleResultText;

@property (nonatomic,weak) id<NDRecognizeResultTextViewDelegate> RecognizeResultTextViewDelegate;
@end
