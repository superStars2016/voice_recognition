//
//  VoiceView.h
//  VoiceRecognitio
//
//  Created by lander on 16/6/2.
//  Copyright © 2016年 lander. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol VoiceViewDelegate;
@interface VoiceView : UIView

/**
 *  显示
 */
-(void)show;
/**
 *  隐藏
 */
-(void)dissMiss;

/**
 *  获取voiceView单例
 *
 *  @return voiceView单例
 */
+(instancetype)sharedVoiceView;

/** voiceView代理 */
@property(nonatomic,weak) id<VoiceViewDelegate> delegate;
@end

@protocol VoiceViewDelegate <NSObject>
@required
-(void)VoiceView:(VoiceView *)voiceView didFinishedVoiceRegenizeWithData:(NSString *)strData;
@end