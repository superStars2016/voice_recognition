//
//  langugePickView.h
//  VoiceRecognizition
//
//  Created by lander on 16/6/28.
//  Copyright © 2016年 lander. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol langugePickViewDelegate;
@interface langugePickView : UIView

/** langugePickViewDelegate */
@property(nonatomic,weak) id<langugePickViewDelegate> delegate;

/**
 *  获取实例
 *
 *  @return 获取选择语音pickView
 */
+(instancetype) sharedInstance;
/**
 *  显示
 */
-(void)show;

/**
 *  隐藏
 */
-(void)hide;
@end


@protocol langugePickViewDelegate <NSObject>

@required
/**
 *  点击了完成选择语言按钮
 *
 *  @param langugePickView langePickView
 *  @param languegeString  选择的语言-code
 */
-(void)langugePickView:(langugePickView *)langugePickView didSelectLangeue:(NSString *)languegeString langueCode:(NSString *)langueCode;

@end