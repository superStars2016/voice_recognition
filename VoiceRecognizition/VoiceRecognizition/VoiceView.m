//
//  VoiceView.m
//  VoiceRecognizition
//
//  Created by lander on 16/6/20.
//  Copyright © 2016年 lander. All rights reserved.
//

#import "VoiceView.h"
@interface VoiceView()


@end
@implementation VoiceView
-(void)drawRect:(CGRect)rect{

    NSLog(@"sdfdf");
}
/**
 *  获取voiceView实例
 *
 *  @return <#return value description#>
 */
+(instancetype)sharedVoiceView{
    return  [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil][0];
    
}
@end
